<?php

namespace App\View\Components\Layout;

use Illuminate\Contracts\View\View;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\Component;

class Base extends Component
{
    public function __construct() {}

    public function linkHome(): string
    {
        if (Auth::check()) {
            return route('dashboard');
        }

        return route('index');
    }

    public function render(): View
    {
        return view('components.layout.base');
    }
}
