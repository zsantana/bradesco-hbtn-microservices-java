#!/bin/bash

BASE="0x04/endpoints_JPA+H2_database"
REPO="$BASE/com/example/jpa_h2_demo/repository"
CTRL="$BASE/com/example/jpa_h2_demo/controller"

mkdir -p $REPO
mkdir -p $CTRL

## ClienteRepository.java
cat > $REPO/ClienteRepository.java <<'EOF'
package com.example.jpa_h2_demo.repository;

import com.example.jpa_h2_demo.model.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ClienteRepository extends JpaRepository<Cliente, Long> {
}
EOF

## EnderecoRepository.java
cat > $REPO/EnderecoRepository.java <<'EOF'
package com.example.jpa_h2_demo.repository;

import com.example.jpa_h2_demo.model.Endereco;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EnderecoRepository extends JpaRepository<Endereco, Long> {
}
EOF

## TelefoneRepository.java
cat > $REPO/TelefoneRepository.java <<'EOF'
package com.example.jpa_h2_demo.repository;

import com.example.jpa_h2_demo.model.Telefone;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TelefoneRepository extends JpaRepository<Telefone, Long> {
}
EOF

## ClienteController.java
cat > $CTRL/ClienteController.java <<'EOF'
package com.example.jpa_h2_demo.controller;

import com.example.jpa_h2_demo.model.Cliente;
import com.example.jpa_h2_demo.repository.ClienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
public class ClienteController {

    @Autowired
    private ClienteRepository clienteRepository;

    @PostMapping("/addClient")
    public ResponseEntity<Cliente> addClient(@RequestBody Cliente cliente) {
        Cliente savedCliente = clienteRepository.save(cliente);
        return new ResponseEntity<>(savedCliente, HttpStatus.CREATED);
    }

    @GetMapping("/findAllClients")
    public ResponseEntity<List<Cliente>> findAllClients() {
        List<Cliente> listaClientes = clienteRepository.findAll();
        return new ResponseEntity<>(listaClientes, HttpStatus.OK);
    }

    @GetMapping("/findClientById/{id}")
    public ResponseEntity<Cliente> findClientById(@PathVariable("id") Long idClient) {
        Optional<Cliente> clienteOptional = clienteRepository.findById(idClient);
        return clienteOptional.map(cliente -> new ResponseEntity<>(cliente, HttpStatus.OK))
                              .orElse(new ResponseEntity<>(HttpStatus.NOT_FOUND));
    }

    @DeleteMapping("/removeClientById/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void removerCliente(@PathVariable("id") Long idClient){
        clienteRepository.deleteById(idClient);
    }

    @PutMapping("/updateClientById/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void updateCliente(@PathVariable("id") Long id, @RequestBody Cliente cliente){
        Optional<Cliente> clienteOptional = clienteRepository.findById(id);
        if (clienteOptional.isPresent()) {
            Cliente clienteExistente = clienteOptional.get();
            clienteExistente.setNome(cliente.getNome());
            clienteExistente.setEmail(cliente.getEmail());
            clienteExistente.setIdade(cliente.getIdade());
            clienteRepository.save(clienteExistente);
        }
    }
}
EOF

## findAll.txt
cat > $BASE/findAll.txt <<'EOF'
[
  {
    "id": 1,
    "nome": "Ze Fulano",
    "idade": 40,
    "email": "zezinho@email.com",
    "telefones": [
      {
        "id": 3,
        "ddd": "18",
        "numero": "98253636"
      }
    ],
    "enderecos": [
      {
        "id": 1,
        "bairro": "CENTRO",
        "cidade": "CIDADE DO NORTE",
        "endereco": "ALI PERTO",
        "estado": "SP",
        "logradouro": "AVENIDA",
        "numero": "100"
      }
    ]
  },
  {
    "id": 2,
    "nome": "Manoel Antunes",
    "idade": 26,
    "email": "manoel@email.com",
    "telefones": [
      {
        "id": 1,
        "ddd": "14",
        "numero": "35445585"
      },
      {
        "id": 2,
        "ddd": "14",
        "numero": "99668855"
      }
    ],
    "enderecos": [
      {
        "id": 2,
        "bairro": "JARDIM BONITO",
        "cidade": "CIDADE DO NORTE",
        "endereco": "LÁ LONGE",
        "estado": "SP",
        "logradouro": "RUA",
        "numero": "487"
      }
    ]
  }
]
EOF

## findById.txt
cat > $BASE/findById.txt <<'EOF'
{
  "id": 2,
  "nome": "Manoel Antunes",
  "idade": 26,
  "email": "manoel@email.com",
  "telefones": [
    {
      "id": 1,
      "ddd": "14",
      "numero": "35445585"
    },
    {
      "id": 2,
      "ddd": "14",
      "numero": "99668855"
    }
  ],
  "enderecos": [
    {
      "id": 2,
      "bairro": "JARDIM BONITO",
      "cidade": "CIDADE DO NORTE",
      "endereco": "LÁ LONGE",
      "estado": "SP",
      "logradouro": "RUA",
      "numero": "487"
    }
  ]
}
EOF

echo "Arquivos criados em $BASE"