package com.example.jpa_h2_demo.model;

import javax.persistence.*;

import com.example.jpa_h2_demo.model.Cliente;
import com.fasterxml.jackson.annotation.JsonBackReference;

@Entity
@JsonPropertyOrder({"id", "ddd", "numero"})
public class Telefone {

    @Id
    private Long id;

    private String ddd;
    private String numero;

    @ManyToOne
    @JoinColumn(name = "cliente_id")
    @JsonBackReference
    private Cliente cliente;

    // Getters e Setters

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getDdd() { return ddd; }
    public void setDdd(String ddd) { this.ddd = ddd; }

    public String getNumero() { return numero; }
    public void setNumero(String numero) { this.numero = numero; }

    public Cliente getCliente() { return cliente; }
    public void setCliente(Cliente cliente) { this.cliente = cliente; }
}