build:
	@mkdir -p out
	@~/Github/chip8/c8asm -o out/game.ch8 src/game.asm
	@echo "Build available at ./out/game.ch8."
	@echo "Making VBox config..."
	@echo '{"emu_type":"chip8", "rom_path":"./out/game.ch8", "instruction_rate": 1000.0}' > ./out/game.json
	@echo "VBox config complete."

clean:
	@rm -rf out
	@echo "Output cleaned."

run:
	@~/Github/chip8/chip8 ./out/game.ch8

run-vbox:
	@v run ~/Desktop/Projects/VBox/ ./out/game.json