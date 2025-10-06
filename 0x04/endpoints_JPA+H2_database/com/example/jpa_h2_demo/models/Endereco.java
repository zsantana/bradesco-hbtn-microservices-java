package com.example.jpa_h2_demo.model;

import javax.persistence.*;

import com.example.jpa_h2_demo.model.Cliente;
import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@JsonPropertyOrder({"id", "bairro", "cidade", "endereco", "estado", "logradouro", "numero"})
public class Endereco {

    @Id
    private Long id;

    private String bairro;
    private String cidade;
    private String endereco;
    private String estado;
    private String logradouro;
    private String numero;

    @ManyToOne
    @JoinColumn(name = "cliente_id")
    @JsonBackReference
    private Cliente cliente;

    // Getters e Setters

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getBairro() { return bairro; }
    public void setBairro(String bairro) { this.bairro = bairro; }

    public String getCidade() { return cidade; }
    public void setCidade(String cidade) { this.cidade = cidade; }

    public String getEndereco() { return endereco; }
    public void setEndereco(String endereco) { this.endereco = endereco; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }

    public String getLogradouro() { return logradouro; }
    public void setLogradouro(String logradouro) { this.logradouro = logradouro; }

    public String getNumero() { return numero; }
    public void setNumero(String numero) { this.numero = numero; }

    public Cliente getCliente() { return cliente; }
    public void setCliente(Cliente cliente) { this.cliente = cliente; }
}