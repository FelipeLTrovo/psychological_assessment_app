# Psychological Assessment

![image](https://github.com/FelipeLTrovo/psychological_assessment_app/assets/15835917/06a38fcb-d3f9-4f5c-b049-0a33aea98f79)


👋 Hello and welcome!

A simple application for psychologists to apply an instrument to a patient.

As of now, the application presents the following features:

- Register, show, edit and delete Psychologists, Patients, Instruments, Questions, Answers and Instrument Applications.
- A psycologist is able to send an instrument to a patient email and see its score after the instrument application is finished.
- A patient is able to resolve the instrument by clicking on the link sent to his email.

**:warning: Hint:** This project is configured to run under Docker only.

- **🛠 Docker Development Environment**
    - :computer: [Linux Ubuntu LTS](https://ubuntu.com/download/desktop)
    - 🐳 [Docker](https://docs.docker.com/engine/installation/)
    - 🐳 [Docker Compose](https://docs.docker.com/compose/)
    - **💡 Hint:** [Docker Documentation](https://docs.docker.com/)

# Setup

## 🐳 Docker Development Environment

After installing both docker and docker-compose, in the project root directory, execute the following command to enter our container shell:

```sh
docker-compose run rails_app bash
```

Build the project assets pipeline by running inside the container shell:

```sh
rails assets:precompile
```

Inside the container shell, create, migrate and populate the database by running: 

```sh
rails db:create db:migrate db:seed
```

In another terminal tab, run the command below to start the application:

```sh
docker-compose up
```



🚀 :clap: Finally, you can access the application by heading out to: [localhost:3000](http://localhost:3000)

**:warning: Hint:** You can log in to the system by using the default admin account or creating your own. The default admin account is the following:
```
email: admin@admin.com
password: 123456
```


**:warning: Hint:** You can access the Mailcatcher application by heading out to: [localhost:1080](http://localhost:1080). You are going to need it in order to check Patients email.

In order to run the test suite, execute the command below inside the container shell:

```sh
rspec
```
