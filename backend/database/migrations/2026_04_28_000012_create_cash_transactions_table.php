<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('cash_transactions', function (Blueprint $table) {
            $table->id();
            $table->foreignId('shop_id')->constrained()->cascadeOnDelete();
            $table->enum('type', [
                'sale',
                'customer_payment',
                'purchase_payment',
                'expense',
                'owner_given',
                'owner_taken',
            ]);
            $table->enum('direction', ['in', 'out']);
            $table->decimal('amount', 12, 2);
            $table->nullableMorphs('reference');
            $table->string('method')->nullable();
            $table->text('note')->nullable();
            $table->timestamps();

            $table->unique(['reference_id', 'reference_type', 'type']);
            $table->index(['shop_id', 'created_at']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('cash_transactions');
    }
};
