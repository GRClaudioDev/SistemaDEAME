<?php

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
})->name('index');

Route::get('sistema', function () {
    return 'Dashboard';
})->name('dashboard');

Route::get('login', function () {
    Auth::loginUsingId(1);

    return redirect()->route('index');
});

Route::get('logout', function () {
    Auth::logout();

    return redirect()->route('index');
});
