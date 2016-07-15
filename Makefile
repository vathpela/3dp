
TARGETS=vacuum_shoe.png vacuum_shoe.stl

all : $(TARGETS)

vacuum_shoe.png vacuum_shoe.stl : vacuum_shoe.scad notcher.scad geometry.scad
	openscad -o $@ --render $<

clean :
	@rm -vf $(TARGETS)
