<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('pedidos', function (Blueprint $table) {
            $table->id();
            $table->string('nome');
            $table->string('telefone');
            $table->string('altura');
            $table->string('largura');
            $table->string('frase');
            $table->string('corPlaca');
            $table->string('corFrase');
            $table->string('area');
            $table->string('custoMaterial');
            $table->string('custoDesenho');
            $table->string('valorPlaca');            
            $table->string('pedidoAtivo');
            $table->timestamps();
            $table->softdeletes();
            });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pedidos');
    }
};
