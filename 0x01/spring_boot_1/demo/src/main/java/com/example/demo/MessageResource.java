// demo/src/main/java/com/example/demo/MessageResource.java
package com.example.demo;

import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(value = "/messages")
public class MessageResource {

    @GetMapping("/simpleMessageWelcome")
    public String simpleMessageWelcome() {
        return "BEM VINDO A AULA DE MICROSSERVIÇO USANDO SPRING BOOT !!!";
    }

    @GetMapping("/login")
    public String login(@RequestParam(required = false) String user,
                        @RequestParam(required = false) String password) {
        if (user == null || password == null || user.trim().isEmpty() || password.trim().isEmpty()) {
            return "USUÁRIO E SENHA NÃO INFORMADOS";
        }
        if (user.length() > 15 || password.length() > 15) {
            return "USUÁRIO E SENHA INVÁLIDOS";
        }
        return "LOGIN EFETUADO COM SUCESSO !!!";
    }
}