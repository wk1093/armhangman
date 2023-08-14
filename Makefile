# Compile all the .s and .c files into their .o counterparts
# and then link them all together into a single executable
# then delete all the .o files

# Variables
OBJS = $(patsubst src/%.s, obj/%.o, $(wildcard src/*.s)) $(patsubst src/%.c, obj/%.o, $(wildcard src/*.c)) $(patsubst src/%.S, obj/%.o, $(wildcard src/*.S))
EXE = program
ASMFLAGS = -g
CFLAGS = -g

# Rules
all: $(EXE)

$(EXE): $(OBJS)
	gcc -o $(EXE) $(OBJS)
obj/%.o: src/%.s
	gcc -c $< -o $@ $(ASMFLAGS)
obj/%.o: src/%.c
	gcc -c $< -o $@ $(CFLAGS)
obj/%.o: src/%.S
	gcc -c $< -o $@ $(ASMFLAGS)

clean:
	rm -f $(OBJS) $(EXE)

debug: $(EXE) # easier than have to type "gdb program" after running make
	gdb $(EXE)

run: $(EXE) # easier than have to type "./program" after running make
	./$(EXE) words.txt

lines:
	wc -l src/*.s
linesc:
	wc -l src/*.c src/*.s

# make new myFunction (creates a new .s file with the given name) if second arg is specified r4 and r5 are also pushed
ifeq (new,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  NEW_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(NEW_ARGS):;@:)
endif

new:
	python new.py $(NEW_ARGS)

zip:
	tar -cf output.tar Makefile src obj $(EXE) new.py
	gzip output.tar


	