package com.example.demo;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @description:
 * @author: yunsheng
 * @time: 2021/10/26 17:19
 */
@RestController
public class DemoController {
    @GetMapping("/hello")
    public String hello() {
        return "hello Docker";
    }
}
