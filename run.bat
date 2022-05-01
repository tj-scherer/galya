@echo off
cd /d %~dp0
CALL .venv\Scripts\activate.bat
python -m src