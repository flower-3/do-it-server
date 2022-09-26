package com.doit.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

    @GetMapping("/")
    public String Hello() {
        return "Hello spring Boot X Docker X AWS EC2 ver 1.1";
    }
}
