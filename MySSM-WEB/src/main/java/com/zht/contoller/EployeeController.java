package com.zht.contoller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mysql.cj.api.xdevapi.Collection;
import com.zht.bean.Employee;
import com.zht.bean.Msg;
import com.zht.service.EmployeeService;

/**
 * 请求格式：
 * /emp post 保存
 *  /emp/id get 为查询
 *  /emp/id put 修改
 *  /emp/id delet 删除
 *
 * @author zht
 *
 */
@Controller
public class EployeeController {

	@Autowired
	EmployeeService employeeService;

	/**
	 * 删除单个或多个
	 * @param empId
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/emp/{empId_str}",method = RequestMethod.DELETE)
	public Msg delEmpById(@PathVariable("empId_str")String empIds) {

		if(empIds.contains("-")) {
			List<Integer> del_ids = new ArrayList<>();
			String[] ids = empIds.split("-");
			for (String id : ids) {
				del_ids.add(Integer.parseInt(id));
			}
				employeeService.delEmpByBatch(del_ids);
		}else {
			Integer empId = Integer.parseInt(empIds);
			employeeService.delEmpById(empId);
		}
		return Msg.success();

	}

	/**
	 * AJAX可以直接发put请求，请求体中有数据但employee没封装上
	 * 	 在mapper中拼接sql语句时由于只有主键有值，导致更新语名无set而报错
	 * 封装不成功的原因：
	 * 	 tomcat:
	 * 		1将请求封装成为一个map
	 * 		2 request.getParameter("empName")会从这个map中取值
	 * 		3 springmvc封装pojo对象时会把其中每个属性的值通过request.getParameter
	 *
	 * 		tomcat对put请求不会封装请求体中的数据为map,只有post才会被封装。
	 * 			org.apache.catlina.connector.Request--parseParameters() 3111行处
	 *
	 *	解决：方案
	 * 		配置FormContentFilter与HttpPutFormContentFilter功能类似,后者从5.1不推荐使用了，解决AJAX直接发送put请求时，tomcat不解析的问题
	 *
	 * 更新员工信息
	 *  /emp/{id}中的id须与对象内的属性名称一致
	 * @param employee
	 * @return
	 */
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employee employee) {
		employeeService.updateEmp(employee);
		return Msg.success();
	}

	/**
	 * 按主键ID查询
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id) {
		Employee employee =  employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}

	/**
	 * 检查名字是否重复
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkEmpName")
	@ResponseBody
	public Msg checkEmpName(@RequestParam("empName")String empName) {
		//后台正则校验用户名，也可以在前台进行校验后再进行重名校验
		String regex = "(^[0-9a-zA-Z_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
		if(!empName.matches(regex)) {
			return Msg.fail().add("valid_msg", "用户名为6到16位字母或2到5位汉字");
		}

		boolean b = employeeService.checkEmpName(empName);
		if(b) {
			return Msg.success();
		}else {
			return Msg.fail().add("valid_msg", "empName已存在");
		}


	}

	/**
	 * 保存雇员信息
	 * 确保数据安全性前端校验、后端校验、数据库约束
	 *
	 * 后台添加JS303校验
	 *  Hibernate-validator
	 * @param employee
	 * @return
	 */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Validated Employee employee, BindingResult result) {

		//封装校验信息
		Map<String, Object> map = new HashMap<String, Object>();
		//校验有错
		if (result.hasErrors()) {
			List<FieldError> fieldErrors = result.getFieldErrors();
			for (FieldError fieldError : fieldErrors) {
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else {

			employeeService.saveEmp(employee);
			return Msg.success();
		}
	}


	/**
	 * 以ajax形式获取emp信息，更具通用性。
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn) {
		PageHelper.startPage(pn, 10);
		List<Employee> emps = employeeService.getAll();

		PageInfo<Employee> page = new PageInfo<>(emps,5);

		return Msg.success().add("pageInfo", page);
	}

	/**
	 * 以表单的形式获取emp信息
	 * @param pn
	 * @param model
	 * @return
	 */
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model) {

		//pagehelper使用：参数页码，分页大小；其后的查询即为分页查询
		PageHelper.startPage(pn, 10);
		List<Employee> emps = employeeService.getAll();

		PageInfo<Employee> page = new PageInfo<>(emps,5);
		model.addAttribute("pageInfo", page);

		return "list";
	}
}







