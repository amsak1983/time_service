.PHONY: server test

BUNDLE_EXEC = bundle exec
PORT = 9292
SERVER_CMD = $(BUNDLE_EXEC) rackup config.ru -p $(PORT)

all: server

server:
	@echo "🚀 Запуск Ruby Rack сервера на http://localhost:$(PORT)..."
	@echo "   Нажмите Ctrl+C для остановки."
	@$(SERVER_CMD)

help:
	@echo "Доступные команды:"
	@echo "  make server         - Запустить Rack сервер (блокирующий)"
	@echo "  make help           - Показать это сообщение"