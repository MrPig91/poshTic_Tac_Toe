function Write-GameResults {
    param(
        $Results 
    )

    $WhiteSpace = (0.. ([console]::WindowWidth - 2) | foreach {"$([char]32)"})

    if ($Results -eq "X"){Write-Host ("
         _____  _                        __   __ __          ___             _
        |  __ \| |                       \ \ / / \ \        / (_)           | |
        | |__) | | __ _ _   _  ___ _ __   \ V /   \ \  /\  / / _ _ __  ___  | |
        |  ___/| |/ _  | | | |/ _  \ '__|  > <     \ \/  \/ / | | '_ \/ __| | |
        | |    | | (_| | |_| |  __/ |     / . \     \  /\  /  | | | | \__ \ |_|
        |_|    |_|\__,_|\__, |\___|_|    /_/ \_\     \/  \/   |_|_| |_|___/ (_)
                         __/ |
                        |___/    " -join "") -ForegroundColor Green

    }
    elseif ($Results -eq "O"){Write-Host ("
     _____  _                          ____   __          ___             _ 
    |  __ \| |                        / __ \  \ \        / (_)           | |
    | |__) | | __ _ _   _  ___ _ __  | |  | |  \ \  /\  / / _ _ __  ___  | |
    |  ___/| |/ _  | | | |/ _ \ '__| | |  | |   \ \/  \/ / | | '_ \/ __| | |
    | |    | | (_| | |_| |  __/ |    | |__| |    \  /\  /  | | | | \__ \ |_|
    |_|    |_|\__,_|\__, |\___|_|     \____/      \/  \/   |_|_| |_|___/ (_)
                     __/ |                                                  
                    |___/                                                   
   " -join "") -ForegroundColor Red
    }
    elseif ($Results -eq "YouWin"){Write-Host ("
    __     __          __          _______ _   _   _    _    _ 
    \ \   / /          \ \        / /_   _| \ | | | |  | |  | |
     \ \_/ /__  _   _   \ \  /\  / /  | | |  \| | | |  | |  | |
      \   / _ \| | | |   \ \/  \/ /   | | | .   | | |  | |  | |
       | | (_) | |_| |    \  /\  /   _| |_| |\  | |_|  |_|  |_|
       |_|\___/ \__,_|     \/  \/   |_____|_| \_| (_)  (_)  (_)
                                                               " -join "") -ForegroundColor Green
    }
    elseif ($Results -eq "YouLost"){Write-Host ("
    __     __           _      ____   _____ _______   _    _    _ 
    \ \   / /          | |    / __ \ / ____|__   __| | |  | |  | |
     \ \_/ /__  _   _  | |   | |  | | (___    | |    | |  | |  | |
      \   / _ \| | | | | |   | |  | |\___ \   | |    | |  | |  | |
       | | (_) | |_| | | |____ |__| |____) |  | |    |_|  |_|  |_|
       |_|\___/ \__,_| |______\____/|_____/   |_|    (_)  (_)  (_)$whiteSpace`n$whiteSpace                                                              
   " -join "") -ForegroundColor Red
   Write-Host "$whiteSpace`n$whiteSpace"

    }
    else{Write-Host ("
         _____  _____      __          __
        |  __ \|  __ \    /\ \        / /
        | |  | | |__) |  /  \ \  /\  / / 
        | |  | |  _  /  / /\ \ \/  \/ /  
        | |__| | | \ \ / ____ \  /\  /  
        |_____/|_|  \_\_/    \_\/  \/ $whiteSpace
$whiteSpace`n$whiteSpace" -join "")
        Write-Host "$whiteSpace`n$whiteSpace"

    }
}