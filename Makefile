SRC_DIR := BootViz-241EE121/src
BIN_DIR := BootViz-241EE121/bin

# NASM settings
NASM := nasm
NASM_FLAGS := -f bin

SRC_FILES := \
    $(SRC_DIR)/Assignment\ 2/boot.asm \
    $(SRC_DIR)/Assignment\ 3/boot.asm

IMG_FILES := \
    $(BIN_DIR)/assignment2.img \
    $(BIN_DIR)/assignment3.img

all: $(IMG_FILES)

$(BIN_DIR)/assignment2.img: $(SRC_DIR)/Assignment\ 2/boot.asm
	@mkdir -p $(BIN_DIR)
	$(NASM) $(NASM_FLAGS) -o $@ $<

$(BIN_DIR)/assignment3.img: $(SRC_DIR)/Assignment\ 3/boot.asm
	@mkdir -p $(BIN_DIR)
	$(NASM) $(NASM_FLAGS) -o $@ $<

clean:
	rm -f $(BIN_DIR)/assignment2.img $(BIN_DIR)/assignment3.img
