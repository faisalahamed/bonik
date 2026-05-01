<?php

namespace App\Http\Controllers;

use App\Models\Purchase;
use App\Models\PurchaseItem;
use App\Models\PurchasePayment;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;
use Illuminate\Validation\ValidationException;

class PurchaseController extends Controller
{
    public function index(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'shop_id' => ['required', 'uuid', 'exists:shops,id'],
        ]);

        return response()->json([
            'purchases' => Purchase::query()
                ->where('shop_id', $validated['shop_id'])
                ->with(['items', 'payments'])
                ->orderByDesc('created_at')
                ->get(),
        ]);
    }

    public function store(Request $request): JsonResponse
    {
        $validator = Validator::make($request->all(), [
            'purchase' => ['required', 'array'],
            'purchase.id' => ['required', 'uuid'],
            'purchase.shop_id' => ['required', 'uuid', 'exists:shops,id'],
            'purchase.supplier_id' => ['required', 'uuid', 'exists:suppliers,id'],
            'purchase.total' => ['required', 'numeric', 'min:0'],
            'purchase.other_charge' => ['nullable', 'numeric', 'min:0'],
            'purchase.description' => ['nullable', 'string'],
            'purchase.buying_memo_url' => ['nullable', 'string', 'max:2048'],
            'purchase.status' => ['required', Rule::in(['pending', 'completed'])],
            'purchase.created_at' => ['nullable', 'date'],
            'purchase.updated_at' => ['nullable', 'date'],

            'items' => ['required', 'array', 'min:1'],
            'items.*.id' => ['required', 'uuid'],
            'items.*.shop_id' => ['required', 'uuid', 'exists:shops,id'],
            'items.*.purchase_id' => ['nullable', 'uuid'],
            'items.*.category_id' => ['nullable', 'uuid', 'exists:categories,id'],
            'items.*.product_name' => ['required', 'string', 'max:255'],
            'items.*.buying_price' => ['required', 'numeric', 'min:0'],
            'items.*.est_selling_price' => ['nullable', 'numeric', 'min:0'],
            'items.*.quantity' => ['required', 'integer', 'min:0'],
            'items.*.barcode' => ['nullable', 'string', 'max:255'],
            'items.*.other_charge' => ['nullable', 'numeric', 'min:0'],
            'items.*.description' => ['nullable', 'string'],
            'items.*.product_image' => ['nullable', 'string', 'max:2048'],
            'items.*.created_at' => ['nullable', 'date'],
            'items.*.updated_at' => ['nullable', 'date'],

            'payments' => ['nullable', 'array'],
            'payments.*.id' => ['required', 'uuid'],
            'payments.*.shop_id' => ['required', 'uuid', 'exists:shops,id'],
            'payments.*.purchase_id' => ['nullable', 'uuid'],
            'payments.*.payments' => ['required', 'numeric', 'min:0'],
            'payments.*.description' => ['nullable', 'string'],
            'payments.*.created_at' => ['nullable', 'date'],
            'payments.*.updated_at' => ['nullable', 'date'],
        ]);

        if ($validator->fails()) {
            throw new ValidationException($validator);
        }

        $data = $validator->validated();
        $purchaseData = $data['purchase'];

        DB::transaction(function () use ($data, $purchaseData): void {
            Purchase::query()->updateOrCreate(
                ['id' => $purchaseData['id']],
                [
                    'id' => $purchaseData['id'],
                    'shop_id' => $purchaseData['shop_id'],
                    'supplier_id' => $purchaseData['supplier_id'],
                    'total' => $purchaseData['total'],
                    'other_charge' => $purchaseData['other_charge'] ?? 0,
                    'description' => $purchaseData['description'] ?? null,
                    'buying_memo_url' => $purchaseData['buying_memo_url'] ?? null,
                    'status' => $purchaseData['status'],
                    'created_at' => $purchaseData['created_at'] ?? now(),
                    'updated_at' => $purchaseData['updated_at'] ?? now(),
                ],
            );

            foreach ($data['items'] as $item) {
                PurchaseItem::query()->updateOrCreate(
                    ['id' => $item['id']],
                    [
                        'id' => $item['id'],
                        'shop_id' => $item['shop_id'],
                        'purchase_id' => $purchaseData['id'],
                        'category_id' => $item['category_id'] ?? null,
                        'product_name' => $item['product_name'],
                        'buying_price' => $item['buying_price'],
                        'est_selling_price' => $item['est_selling_price'] ?? null,
                        'quantity' => $item['quantity'],
                        'barcode' => $item['barcode'] ?? null,
                        'other_charge' => $item['other_charge'] ?? 0,
                        'description' => $item['description'] ?? null,
                        'product_image' => $item['product_image'] ?? null,
                        'created_at' => $item['created_at'] ?? now(),
                        'updated_at' => $item['updated_at'] ?? now(),
                    ],
                );
            }

            foreach ($data['payments'] ?? [] as $payment) {
                PurchasePayment::query()->updateOrCreate(
                    ['id' => $payment['id']],
                    [
                        'id' => $payment['id'],
                        'shop_id' => $payment['shop_id'],
                        'purchase_id' => $purchaseData['id'],
                        'payments' => $payment['payments'],
                        'description' => $payment['description'] ?? null,
                        'created_at' => $payment['created_at'] ?? now(),
                        'updated_at' => $payment['updated_at'] ?? now(),
                    ],
                );
            }
        });

        return response()->json([
            'purchase' => Purchase::query()->find($purchaseData['id']),
        ], 201);
    }
}
