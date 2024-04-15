run:
		docker-compose up -d && rails db:create db:migrate db:seed
stop:
		docker-compose down