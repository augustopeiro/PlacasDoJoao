<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Administrador;

class AdministradorController extends Controller
{
    public function allAdministradors(Request $request){
        try{
            //tenta buscar a lista de administradors$administradors
            $administradors = Administrador::orderBy('nome')->get();
            return response()->json([
                'administradors' => $administradors
            ], 200);
        }catch (\Throwable $th){
            //caso algum comando de try falhe, retorna o errro
            return response()->json([
                'message' => 'Erro ao buscar: '.$th->getMessage(),
            ], 500);

        }
    }

    public function cadastraAdministrador(Request $request){
        //vai receber os dados do flutter e cadastrar no bd
        try{
            //tenta buscar a lista de administradors$administradors
            $administrador = new Administrador();
            $administrador->nome = $request->administrador['nome'];
            $administrador->email = $request->administrador['email'];
            $administrador->senha = $request->administrador['senha'];            
            $administrador->telefone = $request->administrador['telefone'];            
            $administrador->save();
            return response()->json([
                'administrador' => $administrador
            ], 200);
        }catch (\Throwable $th){
            //caso algum comando de try falhe, retorna o errro
            return response()->json([
                'message' => 'Erro ao cadastrar administrador: '.$th->getMessage(),
            ], 500);

        }
        
    }
    public function verificaAdministrador(Request $request){
        try{
            
            $administrador = Administrador::where('email', '=', $request->email)->where('senha', '=', $request->senha)->first();

            if(!$administrador){
                throw Exception("Administrador não encontrado");
            }
            
            return response()->json([
                'administrador' => true
            ], 200);
        }catch (\Throwable $th){
            //caso algum comando de try falhe, retorna o errro
            return response()->json([
                'message' => 'Erro ao buscar: '.$th->getMessage(),
            ], 500);

        }

    }
}
