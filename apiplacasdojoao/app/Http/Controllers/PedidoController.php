<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Pedido;

class PedidoController extends Controller
{
    public function allPedidos(Request $request){
        try{
            
            $pedidos = Pedido::orderBy('nome')->get();
            return response()->json([
                'pedidos' => $pedidos
            ], 200);
        }catch (\Throwable $th){
            //caso algum comando de try falhe, retorna o errro
            return response()->json([
                'message' => 'Erro ao buscar: '.$th->getMessage(),
            ], 500);

        }
    }

    public function cadastraPedido(Request $request){
        //vai receber os dados do flutter e cadastrar no bd
        try{
            //tenta buscar a lista de pedidos
            $pedido = new Pedido();
            $pedido->nome = $request->pedido['nome'];
            $pedido->altura = $request->pedido['altura'];
            $pedido->largura = $request->pedido['largura'];
            $pedido->frase = $request->pedido['frase'];
            $pedido->corPlaca = $request->pedido['corPlaca'];
            $pedido->telefone = $request->pedido['telefone'];
            $pedido->corFrase = $request->pedido['corFrase'];
            $pedido->area = $request->pedido['area'];
            $pedido->custoMaterial = $request->pedido['custoMaterial'];
            $pedido->custoDesenho = $request->pedido['custoDesenho'];
            $pedido->valorPlaca = $request->pedido['valorPlaca'];           
            $pedido->pedidoAtivo = $request->pedido['pedidoAtivo'];            
            $pedido->save();
            return response()->json([
                'pedido' => $pedido
            ], 200);
        }catch (\Throwable $th){
            //caso algum comando de try falhe, retorna o errro
            return response()->json([
                'message' => 'Erro ao cadastrar pedido: '.$th->getMessage(),
            ], 500);

        }

       
        
    }


    public function atualizaPedido(Request $request, $id){
        try{
            $pedido = Pedido::findOrFail($id);
            $pedido->update = $request->pedido['false'];
            $pedido->save();
            return response()->json([
                'pedido' => $pedido
            ], 200);
        }catch (\Throwable $th){
            //caso algum comando de try falhe, retorna o erro
            return response()->json([
                'message' => 'Erro ao atualizar pedido: '.$th->getMessage(),
            ], 500);
    
        }
    }

    // public function allPedidos(Request $request){
    //     try{
    //         //tenta buscar a lista de pedidos
    //         $pedidos = Pedido::orderBy('id')->get();
    //         return response()->json([
    //             'pedidos' => $pedidos
    //         ], 200);
    //     }catch (\Throwable $th){
    //         //caso algum comando de try falhe, retorna o errro
    //         return response()->json([
    //             'message' => 'Erro ao buscar: '.$th->getMessage(),
    //         ], 500);

    //     }
    // }
    
   
}
