#!/bin/bash
# setup_user_api.sh
# Criação automatizada da UserAPI com validações e tratamento de exceções

set -e

echo "[INFO] Gerando estrutura do projeto Maven Spring Boot..."

# # Step 1: Gerar projeto base
# mvn archetype:generate                                               \
#     -DgroupId=com.example.demo                                      \
#     -DartifactId=demo                                               \
#     -DarchetypeArtifactId=maven-archetype-quickstart                \
#     -DinteractiveMode=false

# cd demo

# Step 2: Limpar src gerada, criar o src padrão do Spring Boot
rm -rf src
mkdir -p src/main/java/com/example/demo/controller
mkdir -p src/main/java/com/example/demo/exception
mkdir -p src/main/resources

echo "[INFO] Gerando arquivo pom.xml..."
cat <<'EOF' > pom.xml
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.example</groupId>
    <artifactId>demo</artifactId>
    <version>0.0.1-SNAPSHOT</version>
    <packaging>jar</packaging>
    <name>demo</name>
    <description>Demo project for Spring Boot</description>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>2.7.5</version>
        <relativePath/>
    </parent>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <scope>runtime</scope>
        </dependency>
    </dependencies>
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
EOF

echo "[INFO] Gerando application.properties..."
cat <<EOF > src/main/resources/application.properties
server.port=8081
server.servlet.context-path=/user-api
EOF

echo "[INFO] Gerando DemoApplication.java..."
cat <<EOF > src/main/java/com/example/demo/DemoApplication.java
package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DemoApplication {
    public static void main(String[] args) {
        SpringApplication.run(DemoApplication.class, args);
    }
}
EOF

#############################
# CONTROLLER
#############################
echo "[INFO] Gerando UserController.java..."
cat <<'EOF' > src/main/java/com/example/demo/controller/UserController.java
package com.example.demo.controller;

import com.example.demo.exception.CPFException;
import com.example.demo.exception.UserIdException;
import com.example.demo.exception.UserNameException;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/users")
public class UserController {

    @GetMapping("/user-id/{id}")
    public String findUserById(@PathVariable int id) {
        if (id > 0 && id < 100) {
            return "You have entered valid ID";
        } else {
            throw new UserIdException(String.valueOf(id));
        }
    }

    @GetMapping("/user-name/{userName}")
    public String findUserByName(@PathVariable String userName) {
        if (userName != null && userName.length() > 3 && userName.length() < 15) {
            return "You have entered valid USERNAME";
        } else {
            throw new UserNameException(userName);
        }
    }

    @GetMapping("/user-cpf/{cpf}")
    public String findUserByCPF(@PathVariable String cpf) {
        if (cpf != null && cpf.length() > 3 && cpf.length() < 15) {
            if (isCPF(cpf)) {
                return "You have entered valid CPF";
            } else {
                throw new CPFException(cpf);
            }
        } else {
            throw new CPFException(cpf);
        }
    }

    public boolean isCPF(String CPF) {
        return CPF.matches("\\d{11}");
    }
}
EOF

#############################
# EXCEPTIONS
#############################
echo "[INFO] Gerando Exception classes..."

# UserIdException
cat <<EOF > src/main/java/com/example/demo/exception/UserIdException.java
package com.example.demo.exception;

public class UserIdException extends RuntimeException {
    public UserIdException(String message) {
        super(message);
    }
}
EOF

# UserNameException
cat <<EOF > src/main/java/com/example/demo/exception/UserNameException.java
package com.example.demo.exception;

public class UserNameException extends RuntimeException {
    public UserNameException(String message) {
        super(message);
    }
}
EOF

# CPFException
cat <<EOF > src/main/java/com/example/demo/exception/CPFException.java
package com.example.demo.exception;

public class CPFException extends RuntimeException {
    public CPFException(String message) {
        super(message);
    }
}
EOF

# UserErrorResponse
cat <<EOF > src/main/java/com/example/demo/exception/UserErrorResponse.java
package com.example.demo.exception;

public class UserErrorResponse {
    private int status;
    private String message;

    public UserErrorResponse() {}

    public UserErrorResponse(int status, String message) {
        this.status = status;
        this.message = message;
    }

    public int getStatus() {
        return status;
    }
    public void setStatus(int status) {
        this.status = status;
    }
    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }
}
EOF

# ExceptionService
cat <<EOF > src/main/java/com/example/demo/exception/ExceptionService.java
package com.example.demo.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ExceptionService {

    @ExceptionHandler
    public ResponseEntity<UserErrorResponse> handleException(CPFException err) {
        UserErrorResponse uer = new UserErrorResponse();
        uer.setStatus(HttpStatus.BAD_REQUEST.value());
        uer.setMessage("You have entered CPF " + err.getMessage() + " invalid.");
        return new ResponseEntity<>(uer, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler
    public ResponseEntity<UserErrorResponse> handleException(UserIdException err) {
        UserErrorResponse uer = new UserErrorResponse();
        uer.setStatus(HttpStatus.BAD_REQUEST.value());
        uer.setMessage("You have entered ID " + err.getMessage() + " invalid.");
        return new ResponseEntity<>(uer, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler
    public ResponseEntity<UserErrorResponse> handleException(UserNameException err) {
        UserErrorResponse uer = new UserErrorResponse();
        uer.setStatus(HttpStatus.BAD_REQUEST.value());
        uer.setMessage("You have entered USERNAME " + err.getMessage() + " invalid.");
        return new ResponseEntity<>(uer, HttpStatus.BAD_REQUEST);
    }
}
EOF

echo "[OK] Projeto UserAPI criado!"
echo ""
echo "Para rodar a aplicação execute:"
echo "  cd demo"
echo "  mvn spring-boot:run"
echo ""
echo "Endpoints:"
echo "  GET http://localhost:8081/user-api/users/user-id/{id}"
echo "  GET http://localhost:8081/user-api/users/user-name/{username}"
echo "  GET http://localhost:8081/user-api/users/user-cpf/{cpf}"