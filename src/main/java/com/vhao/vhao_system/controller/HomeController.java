package com.vhao.vhao_system.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    private static final String VERSION = "1.4.9"; /// Cambia esto en cada despliegue
//
    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("version", VERSION);
        return "index";
    }

    @GetMapping("/productos")
    public String productosPage(Model model) {
        model.addAttribute("version", VERSION);
        return "index";
    }
    
    @GetMapping("/soporte")
    public String soportePage(Model model) {
        model.addAttribute("version", VERSION);
        return "soporte";
    }
}
