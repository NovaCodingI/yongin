package com.test.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import egovframework.ddan.mapper.MemberMapper;
import egovframework.ddan.service.MemberVo;

@RunWith(SpringJUnit4ClassRunner.class) //JUnit 
@WebAppConfiguration
@ContextConfiguration(locations = { "file:src/main/resources/egovframework/spring/*.xml",
        "file:src/main/webapp/WEB-INF/config/egovframework/springmvc/dispatcher-servlet.xml" })
public class TestMapper {
	
	@Autowired
	MemberMapper mapper;
	
	@Test
	public void getList() throws Exception {
		
		List<MemberVo> list = mapper.getList();
		
		for(MemberVo vo : list) {
				
			System.out.println(vo.getM_no()); 
			System.out.println(vo.getName());
			System.out.println(vo.getAge());
		}
		
		
		
	}
}
