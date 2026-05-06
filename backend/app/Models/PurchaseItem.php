<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Attributes\Fillable;
use Illuminate\Database\Eloquent\Concerns\HasUuids;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

#[Fillable(['id', 'shop_id', 'purchase_id', 'category_id', 'product_name', 'buying_price', 'est_selling_price', 'quantity', 'barcode', 'other_charge', 'description', 'product_image', 'created_at', 'updated_at', 'deleted_at'])]
class PurchaseItem extends Model
{
    use HasUuids;
    use SoftDeletes;
}
