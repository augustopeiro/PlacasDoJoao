<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AdministradorController;
use App\Http\Controllers\PedidoController;


/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });

Route::get('/administradors', [AdministradorController::class,'allAdministradors']);
Route::put('/cadastroAdministrador', [AdministradorController::class,'cadastraAdministrador']);
Route::get('/cadastroAdministrador', [AdministradorController::class,'cadastraAdministrador']);
Route::put('/verificaAdministrador', [AdministradorController::class,'verificaAdministrador']);
Route::put('/cadastroPedido', [PedidoController::class,'cadastraPedido']);
Route::get('/cadastroPedido', [PedidoController::class,'cadastraPedido']);
Route::get('/allPedidos', [PedidoController::class,'allPedidos']);
Route::get('/pedidos?data_entrega=$data', [PedidoController::class,'/pedidos?data_entrega=$data']);
Route::put('/atualizaPedido', [PedidoController::class,'atualizaPedido']);
