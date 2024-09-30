# Makefile

# The name of the virtual environment directory
VENV_DIR = .venv

# The python version you want to use for the virtual environment (adjust as needed)
PYTHON = python3

.PHONY: all venv install clean

# Default action
all: venv install

configure:
	@echo "Setting the pre-commit configuration"
	@ $(PYTHON) -m pre-commit install --hook-type commit-msg

# Create the virtual environment if it doesn't exist
venv:
	@echo "Creating virtual environment in $(VENV_DIR)..."
	@$(PYTHON) -m venv $(VENV_DIR)
	@echo "Virtual environment created."

# Install Poetry and install dependencies
install: venv
	@echo "Activating virtual environment and installing Poetry..."
	@$(VENV_DIR)/bin/pip install --upgrade pip
	@$(VENV_DIR)/bin/pip install poetry
	@echo "Running Poetry install..."
	@$(VENV_DIR)/bin/poetry install

# Activate the virtual environment
activate: venv
	@echo "To activate the virtual environment, run:"
	@echo "source $(VENV_DIR)/bin/activate"

# Clean the environment (remove virtual environment)
clean:
	@echo "Cleaning up virtual environment..."
	@rm -rf $(VENV_DIR)
	@echo "Virtual environment removed."

test: venv
	@echo "To test the virtual environment, run:"
	@$(PYTHON) -m pytest
