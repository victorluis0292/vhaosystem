package com.vhao.vhao_system.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String index() {
        return "index"; // esto abre templates/index.html
    }
  @GetMapping("/productos")
public String productosPage() {
    return "index"; // esto abre templates/index.html
}
    
    @GetMapping("/soporte")
public String soportePage() {
    return "soporte"; // esto busca soporte.html en templates
}

}
