<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH",request.getContextPath());
%>

<!-- 以不带/开始的相对路径，找资源时是以当前资源路径为基准，容易出问题
	 以/开始的相对路径，则是以服务器的路径为标准即http://localhost:prot/projectname
 -->
 <script type="text/javascript" src="${APP_PATH}/static/js/jquery-2.1.4.min.js"> </script>
  <link href="${APP_PATH}/static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
  <script src="${APP_PATH}/static/bootstrap/js/bootstrap.min.js"></script>
</head>

<body>

		<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">修改雇员信息</h4>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal">
					  <div class="form-group">
					    <label  class="col-sm-2 control-label">empName</label>
					    <div class="col-sm-10">
						      <p class="form-control-static" id ="empId_edit_static"></p>
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="email_edit_input" class="col-sm-2 control-label">email</label>
					    <div class="col-sm-10">
					      <input type="email" name="email" class="form-control" id="email_edit_input" placeholder="empName@gamil.com">
					    <span id="helpBlockEmail" class="help-block"></span>
					    </div>
					  </div>
					  <div class="form-group">
					  	<label  class="col-sm-2 control-label">gender</label>
					    <div class=" col-sm-10">
					  		<label class="radio-inline">
								<input type="radio" name="gender" id="gender1_edit_input" value="M" checked="checked">男
							</label>
							<label class="radio-inline">
								<input type="radio" name="gender" id="gender2_edit_input" value="F">  女
							</label>
					    </div>
					  </div>
					  <div class="form-group">
					  <label  class="col-sm-2 control-label">depName</label>
					    <div class="col-sm-3">
					      <select class="form-control" name="dId" id="dept_edit_select">	</select>
					    </div>
					  </div>
					</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		        <button type="button" class="btn btn-primary" id = "emp_update_btn">更新</button>
		      </div>
		    </div>
		  </div>
		</div>

	<!-- Modal 添加emp -->
		<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4 class="modal-title" id="myModalLabel">添加雇员信息</h4>
		      </div>
		      <div class="modal-body">
		        <form class="form-horizontal">
					  <div class="form-group">
					    <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
					    <div class="col-sm-10">
					      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
					   	<span id="helpBlockEmpName" class="help-block"></span>
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="email_add_input" class="col-sm-2 control-label">email</label>
					    <div class="col-sm-10">
					      <input type="email" name="email" class="form-control" id="email_add_input" placeholder="empName@gamil.com">
					    <span id="helpBlockEmail" class="help-block"></span>
					    </div>
					  </div>
					  <div class="form-group">
					  	<label  class="col-sm-2 control-label">gender</label>
					    <div class=" col-sm-10">
					  		<label class="radio-inline">
								<input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked">男
							</label>
							<label class="radio-inline">
								<input type="radio" name="gender" id="gender2_add_input" value="F">  女
							</label>
					    </div>
					  </div>
					  <div class="form-group">
					  <label  class="col-sm-2 control-label">depName</label>
					    <div class="col-sm-3">
					      <select class="form-control" name="dId" id="dept_add_select">	</select>
					    </div>
					  </div>
					</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
		        <button type="button" class="btn btn-primary" id = "emp_save_btn">保存</button>
		      </div>
		    </div>
		  </div>
		</div>

	<!-- 数据表格 -->
	<div class="container">
	  <div class="col-md-12">
	  	<h1>员工信息</h1>
	  </div>
	  <div class="col-md-3 col-md-offset-10">
	  	<button id="emp_add_modal_btn" type="button" class="btn btn-success btn-sm"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>新增</button>
	  	<button id="emp_del_all_btn" type="button" class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除</button>
	  </div>
	  <div class="row">
	  	<div class="col-md-12">
	  		<table class="table table-hover table-bordered table-condensed" id="emps_table">
	  			<thead>
		  			<tr>
		  				<th>
		  					<input type="checkbox" id="check_all" ></input>
		  				</th>
		  				<th style="text-align:center">#</th>
		  				<th style="text-align:center">empName</th>
		  				<th style="text-align:center">gender</th>
		  				<th style="text-align:center">email</th>
		  				<th style="text-align:center">depName</th>
		  				<th style="text-align:center">操作</th>
		  			</tr>
	  			</thead>
	  			<tbody>
	  				<!-- 表格信息 -->
	  			</tbody>

	  		</table>
	  	</div>
	  </div>
	  <!-- 分页信息 -->
	  <div class="row">
	  	<!-- 分页页数信息 -->
	  	<div class="col-md-6" id="page_info_area"></div>
	  	<!-- 分页导航 -->
	  	<div class="col-md-6" id="page_nav_area"></div>
	  </div>
	</div>

	<script type="text/javascript">

		var totalRecord,currentPage;

		$(function(){
			goto_page(1);
		});

		//构建雇员信息表格方法
		function build_emp_table(result){
			//清空
			$("#emps_table tbody").empty();

			//获取所有信息列表
			var emps = result.extend.pageInfo.list;
			//遍历
			$.each(emps,function(index, item){
				//alert(item.empName);
				var checkBoxTd = $("<td><input type ='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td style=\"text-align:center\"></td>").append(item.empId);
				var empNameTd = $("<td style=\"text-align:center\"></td>").append(item.empName);
				var genderTd = $("<td style=\"text-align:center\"></td>").append(item.gender == 'M' ? "男" :"女");
				var emailTd = $("<td style=\"text-align:center\"></td>").append(item.email);
				var depNameTd = $("<td style=\"text-align:center\"></td>").append(item.department.depName);

				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");

				//编辑按钮添加对应id的自定义属性值
				editBtn.attr("edit_empId",item.empId);

				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm del_btn").append($("<span></span>").addClass("glyphicon glyphicon-remove")).append("删除");
				delBtn.attr("del_empId",item.empId);

				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

				//构建表格
				$("<tr></tr>").append(checkBoxTd)
					.append(empIdTd)
					.append(empNameTd)
					.append(genderTd)
					.append(emailTd)
					.append(depNameTd)
					.append(btnTd)
					.appendTo("#emps_table tbody");
			});
		}

		//分页跳转功能
		function goto_page(pn){
			$("#check_all").prop("checked",false);
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn="+pn,
				type:"GET",
				success:function(result){
					//console.log(result);

					build_emp_table(result);

					build_page_info(result);

					build_page_nav(result);
				}
			});
		}

		//分页信息：当前页数等信息
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前<span class=\"label label-default\">"+result.extend.pageInfo.pageNum+"</span>页，总"+ result.extend.pageInfo.pages+"页，总条"+result.extend.pageInfo.total+"记录")
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}


		//构建分页导航信息方法
		function build_page_nav(result){
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
			 var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));

			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));

			//跳转按钮
			var gotoBtn = $("<button></button>").append("跳转到");
			var gotoInput = $("<input style=\"width:20%\"></input>");
			var gotoPageLi = $("<form style=\"width:30%\"></form>").addClass("navbar-form navbar-right ").append($("<div></div>").addClass("form-group ")
					.append(gotoBtn)
					.append(gotoInput));

			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}else{
				firstPageLi.click(function(){
					goto_page(1);
				});

				prePageLi.click(function(){
					goto_page(result.extend.pageInfo.pageNum-1);
				});

			}

			ul.append(firstPageLi).append(prePageLi);

			 $.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item)
					numLi.addClass("active");
				numLi.click(function(){
					goto_page(item);
				});
				ul.append(numLi);
			});

			 if(result.extend.pageInfo.hasNextPage == false){
					lastPageLi.addClass("disabled");
					nextPageLi.addClass("disabled");
				}else{
					lastPageLi.click(function(){
						goto_page(result.extend.pageInfo.pages);
					});


					nextPageLi.click(function(){
						goto_page(result.extend.pageInfo.pageNum+1);
					});
				}
			 //跳转到页码
			 gotoBtn.click(function(){
				goto_page(gotoInput.val());
			 });

			ul.append(nextPageLi).append(lastPageLi).append(gotoPageLi);

			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}

		function resetForm(element){
			//表单数据重置
			$(element)[0].reset();
			//清除样式
			$(element).find("*").removeClass("has-error has-success");
			//清除提示信息
			$(element).find(".help-block").text("");
		}

		//点击新增按钮弹出模态窗
		$("#emp_add_modal_btn").click(function(){

			//重置表单
			//$("#empAddModal form")[0].reset();
			resetForm("#empAddModal form");

			getDepts("#dept_add_select");

			$("#empAddModal").modal({

				backdrop : "static"
			});
		});

		//从数据库中取数到下拉框
		function getDepts(element){
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					//console.log(result);
					$(element).empty();
					//遍历结果集，回调函数可以无参以this来指代遍历元素对象
					$.each(result.extend.depts,function(index,item){
						var optionEle = $("<option></option>").append(item.depName).attr("value",item.deptId);
						optionEle.appendTo(element);
					});

				}
			});
		}

		function show_validate_msg(element,status,msg){

			$(element).parent().removeClass("has-success has-error");
			$(element).next("span").text("");

			if(status == "success"){
				$(element).parent().addClass("has-success");
				$(element).next("span").text(msg);
			}else if (status == "error") {
				$(element).parent().addClass("has-error");
				$(element).next("span").text(msg);
			}

		}

		//姓名输入后检查用户名是否重复
		$("#empName_add_input").change(function(){
			//发送ajax请求校验用户名是否可用
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkEmpName",
				data:"empName="+empName,
				type:"POST",
				success:function(result){
					if (result.code == 100) {
						show_validate_msg("#empName_add_input","success","empName可用");
						//对保存按钮添加校验状态属性
						$("#emp_save_btn").attr("ajax_valid_empName","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.valid_msg);
						$("#emp_save_btn").attr("ajax_valid_empName","error");
					}
				}
			})

		});


		//校验姓名，邮箱
		function validate_add_form(){
			var empName = $("#empName_add_input").val();
			var regexName = /(^[0-9a-zA-Z_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;

			if(!regexName.test(empName)){
				//alert("用户名为6到16位字母或2到5位汉字");
				show_validate_msg("#empName_add_input","error","用户名为6到16位字母或2到5位汉字");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
			};

			var email = $("#email_add_input").val();
			var regexEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

			if(!regexEmail.test(email)){
				//alert("电子邮箱格式错误");
				show_validate_msg("#email_add_input","error","邮箱格式：empName@company.com");
				return false;
			}else{
				show_validate_msg("#email_add_input","success","");
			}

			return true;

		}


		//模态框保存按钮
			$("#emp_save_btn").click(function() {

			//模态框表单正则校验－前端校验
			if(!validate_add_form()){
				return false;
			};
			//重名校验
			if($(this).attr("ajax_valid_empName")=="error"){
				return false;
			}

			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					//保成功
					if(result.code == 100){
					$("#empAddModal").modal('hide');
					goto_page(totalRecord);

					}else{
						if(undefined != result.extend.errorFields.email){

							show_validate_msg("#email_add_input","error","邮箱格式：empName@company.com");
						}
						if(undefined != result.extend.errorFields.empName){
							show_validate_msg("#empNamel_add_input","error","用户名为6到16位字母或2到5位汉字");
						}

					}
				}
			});
		});

		//编辑按钮绑定
		$(document).on("click",".edit_btn",function(){
			//查部门
			getDepts("#dept_edit_select");
			//查出员工信息
			getEmp($(this).attr("edit_empId"));
			//empId值传递给编辑模态框的更新按钮
			$("#emp_update_btn").attr("edit_empId",$(this).attr("edit_empId"));

			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});

		//为动态创建的删除按钮绑定事件
		$(document).on("click",".del_btn",function(){
			//alert($(this).parents("tr").find("td:eq(1)").text());
			//通过获取删除按钮的父节点tr,找到其下td标签中的第二个即为empName
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del_empId");
			if(confirm("确认删除["+empName+"]吗?")){
				$.ajax({
					url:"${APP_PATH}/emp/"+empId,
					type:"DELETE",
					success:function(result){
						alert(result.msg);
						goto_page(currentPage);
					}
				});
			}
		});

		//获取对应人员信息,id通过对编辑按钮添加对属性
		function getEmp(id){
			$.ajax({
				url:"${APP_PATH}/emp/"+id,
				type:"GET",
				success:function(result){
					var empInfo = result.extend.emp;
					$("#empId_edit_static").text(empInfo.empName);
					$("#email_edit_input").val(empInfo.email);
					$("#empUpdateModal input[name=gender]").val([empInfo.gender]);
					$("#empUpdateModal select").val([empInfo.dId])
				}
			});
		}

		$("#emp_update_btn").click(function(){
			var email = $("#email_edit_input").val();
			var regexEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

			if(!regexEmail.test(email)){
				//alert("电子邮箱格式错误");
				show_validate_msg("#email_edit_input","error","邮箱格式：empName@company.com");
				return false;
			}else{
				show_validate_msg("#email_edit_input","success","");
			}

			$.ajax({
				url:"${APP_PATH}/emp/"+$(this).attr("edit_empId"),
				/* type:"POST",
				data:$("#empUpdateModal form").serialize()+"&_method=PUT", */
				//直接发送put
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result){
					$("#empUpdateModal").modal("hide");
					goto_page(currentPage);
				}
			});
		});

		//选择框
		$("#check_all").click(function(){
			//attr获取checked是undefined;
			//用prop方法获取原生dom属性,attr获取自定义属性
			$(".check_item").prop("checked",$(this).prop("checked"));
		});

		//checkbox绑定单击事件，使全选或部分选中
		$(document).on("click",".check_item",function(){
			//jquery :checked选择器
			var flag = $(".check_item:checked").length == $(".check_item").length;
			$("#check_all").prop("checked",flag);
		});

		//批量删除
		$("#emp_del_all_btn").click(function(){
			var empNames = "";
			var del_idStr = "";
			//遍历每一个选中状态的checkbox，获取对应的empName,empId
			$.each($(".check_item:checked"),function(){
				empNames  += $(this).parents("tr").find("td:eq(2)").text()+",";
				del_idStr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			empNames = empNames.substring(0,empNames.length-1);
			del_idStr = del_idStr.substring(0,del_idStr.length-1);

			if(confirm("确认删除["+empNames+"]吗？")){

					$.ajax({
						url:"${APP_PATH}/emp/"+del_idStr,
						type:"DELETE",
						success:function(result){
							alert(result.msg);
							goto_page(currentPage);
						}
					});

			}
		});

	</script>
</body>
</html>