//package org.example.back.PostgreTest;
//
//import lombok.RequiredArgsConstructor;
//import org.example.back.PostgreTest.dto.TestDto;
//import org.example.back.db2.entity.Test;
//import org.example.back.db2.repository.TestRepository;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.PostMapping;
//import org.springframework.web.bind.annotation.RequestBody;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RestController;
//
//@RestController
//@RequiredArgsConstructor
//@RequestMapping("/api/postgre")
//public class PostGreController {
//
//    private final TestRepository testRepository;
//
//    @PostMapping("")
//    public ResponseEntity<Void> saveTest(@RequestBody TestDto testDto) {
//        String name = testDto.getName();
//
//        Test test = Test.builder()
//                        .name(name).build();
//
//        testRepository.save(test);
//
//        return ResponseEntity.ok().build();
//
//    }
//}
