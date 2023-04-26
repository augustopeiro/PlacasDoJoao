<?php

namespace App;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
// use App\Produto;

class Pedido extends Model
{
    
    use HasFactory;

    protected $fillable = [
        'nome',
        'telefone',
        'altura',
        'largura',
        'frase',
        'corPlaca',
        'corFrase',
        'area',
        'custoMaterial',
        'custoDesenho',
        'valorPlaca',        
        'pedidoAtivo',        
    ];

    protected $hidden = [
        //'senha',
    ];

    protected $appends = [
        //'idade',
    ];

    public function getIdadeAttribute(){
        //return $this->nascimento->diffInYears();
    }

    public function produto(){
        return $this->hasMany(Produto::class);
    }

}
