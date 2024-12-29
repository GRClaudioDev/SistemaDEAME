<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>Sistema DEAME</title>

        <!-- Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">
        <!-- Styles / Scripts -->
        @vite(['resources/css/app.css', 'resources/js/app.js'])
    </head>
    <body class="font-sans bg-base text-primary border-primary">
        <header class="h-20 w-full bg-neutral border-b flex items-center justify-between px-4">
            {{-- Se estiver logado, colocar o link da dashboar, se não, o do index. --}}
            <a href="{{ $linkHome() }}" class="h-2/3">
                <x-icons.deame class="h-full"/>
            </a>
        </header>
        {{ $slot }}
    </body>
</html>
