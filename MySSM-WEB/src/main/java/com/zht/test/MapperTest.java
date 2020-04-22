package com.zht.test;

import java.util.List;
import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.zht.bean.Department;
import com.zht.bean.Employee;
import com.zht.dao.DepartmentMapper;
import com.zht.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper  departmentMapper;

	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	
	@Test
	public void testCRUD() {
		//创建IOC
		//ApplicationContext ioc = new ClassPathXmlApplicationContext("classpath:applicationContext.xml");
		//从容器中获取mapper
		/*
		 * System.out.println(departmentMapper);
		 * 
		 * departmentMapper.insertSelective(new Department(null, "开发部"));
		 * departmentMapper.insertSelective(new Department(null, "测试部"));
		 */
		
		//employeeMapper.insertSelective(new Employee(null,"Tommy","M","Tomm@hotmail.com",3));
		
		Employee e = employeeMapper.selectByPrimaryKey(4);
		System.out.println(e);
		/*
		 * EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class); for(int i
		 * = 0; i < 100; i++) { String empName =
		 * UUID.randomUUID().toString().substring(0, 5); mapper.insertSelective(new
		 * Employee(null, empName, "M", empName + "@gmail.com", 4)); }
		 * System.out.println("插入完毕。。。。。。");
		 */
	List<Employee> result = employeeMapper.selectByExampleWithDept(null);
		
	for(Employee em : result)
		System.out.println(em.getEmpName() + "\t" + em.getEmail());
		
	}

}
