<?php

use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\Auth\SignupOtpController;
use App\Http\Controllers\CategoryController;
use Illuminate\Support\Facades\Route;

Route::post('/auth/login', [LoginController::class, 'store']);
Route::post('/auth/signup/send-otp', [SignupOtpController::class, 'store']);
Route::post('/auth/signup/verify-otp', [SignupOtpController::class, 'verify']);

Route::get('/categories', [CategoryController::class, 'index']);
Route::post('/categories', [CategoryController::class, 'store']);
