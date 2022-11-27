package main

import "core:fmt"
import SDL "vendor:sdl2"

WINDOW_TITLE :: "My Window"
WINDOW_X : i32 = SDL.WINDOWPOS_UNDEFINED // centered
WINDOW_Y : i32 = SDL.WINDOWPOS_UNDEFINED
WINDOW_W : i32 = 600
WINDOW_H : i32 = 600

WINDOW_FLAGS  :: SDL.WINDOW_SHOWN

CTX :: struct
{
	window: ^SDL.Window,
	renderer: ^SDL.Renderer,
}

ctx := CTX{}

main :: proc() {
	// fmt.println("Hellope!")
    SDL.Init(SDL.INIT_VIDEO)

    ctx.window = SDL.CreateWindow(WINDOW_TITLE, WINDOW_X, WINDOW_Y, WINDOW_W, WINDOW_H, WINDOW_FLAGS)
    ctx.renderer = SDL.CreateRenderer(
    	ctx.window,
    	-1,
    	SDL.RENDERER_PRESENTVSYNC | SDL.RENDERER_ACCELERATED | SDL.RENDERER_TARGETTEXTURE,
	)

	SDL.SetRenderDrawColor(ctx.renderer, 0, 0, 0, 0);
    SDL.RenderClear(ctx.renderer);
    SDL.SetRenderDrawColor(ctx.renderer, 255, 0, 0, 255);
	
	for i:i32 = 0; i < WINDOW_W; i += 1 {
		SDL.RenderDrawPoint(ctx.renderer, i, i);
	}
    
	SDL.RenderPresent(ctx.renderer);

    event : SDL.Event
	game_loop: for
	{

    	if SDL.PollEvent(&event)
    	{
    		if event.type == SDL.EventType.QUIT
    		{
    			break game_loop
    		}

			if event.type == SDL.EventType.KEYDOWN
			{
				#partial switch event.key.keysym.scancode
				{
					case .L:
						fmt.println("Log:")
					case .SPACE:
						fmt.println("Space")
				}

			}

			if event.type == SDL.EventType.KEYUP
			{
			}

    	}


    	// paint your background scene
		// SDL.RenderCopy(ctx.renderer, ctx.player.tex, &ctx.player.source, &ctx.player.dest)

		// actual flipping / presentation of the copy
		// read comments here :: https://wiki.libsdl.org/SDL_RenderCopy
		// SDL.RenderPresent(ctx.renderer)

		// clear the old renderer
		// clear after presentation so we remain free to call RenderCopy() throughout our update code / wherever it makes the most sense
		// SDL.RenderClear(ctx.renderer)

	} // end loop


    SDL.DestroyWindow(ctx.window)
	SDL.Quit()
}


