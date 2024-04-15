run:
		docker-compose up -d && rails db:create db:migrate db:seed
stop:
		docker-compose down
rspec:
	docker-compose run rails_app rspec