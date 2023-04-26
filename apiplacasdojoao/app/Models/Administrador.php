<?php

namespace App;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Administrador;

class Administrador extends Model
{
    
    use HasFactory;

    protected $fillable = [
        'nome',
        'telefone',
        'email', 
        'senha',       
        
    ];

    protected $hidden = [
        'senha',
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
