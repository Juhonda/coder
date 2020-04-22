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
	
	<!-- 标题 -->
	<div class="container">
	  <div class="col-md-12">
	  	<h1>员工信息</h1>
	  </div>
	  <div class="col-md-4 col-md-offset-8">
	  	<button type="button" class="btn btn-success btn-sm"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>新增</button>
	  	<button type="button" class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>删除</button>
	  </div>
	  <div class="row">
	  	<div class="col-md-12">
	  		<table class="table table-hover table-bordered">
	  			<tr>
	  				<th>#</th>
	  				<th>empName</th>
	  				<th>gender</th>
	  				<th>email</th>
	  				<th>depName</th>
	  				<th>操作</th>
	  			</tr>
	  			<c:forEach items="${pageInfo.list }" var="emp">
		  			<tr>
		  				<th>${emp.empId }</th>
		  				<th>${emp.empName }</th>
		  				<th>${emp.gender == "M" ? "男" : "女"}</th>
		  				<th>${emp.email }</th>
		  				<th>${emp.department.depName }</th>
		  				<th>
		  					<button class="btn btn-primary"><span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>编辑</button>
		  					<button class="btn btn-danger"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span>移除</button>
		  				</th>
		  			</tr>
	  			</c:forEach>
	  			
	  		</table>
	  	</div>
	  </div>
	  <div class="row">
	  	<div class="col-md-6">
	  		当前${pageInfo.pageNum }页，总${pageInfo.pages }页，总${pageInfo.total}条记录
	  	</div>
	  	<div class="col-md-6">
			<nav aria-label="Page navigation">
			  <ul class="pagination">
			  <li><a href="${APP_PATH }/emps?pn=1">首页</a> </li>
			  <c:if test="${pageInfo.hasPreviousPage}">
			    <li>
			      <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum - 1}" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>			  
			  </c:if>
			    <c:forEach items="${pageInfo.navigatepageNums }" var="pageCurrentNum">
			    		<c:if test="${pageCurrentNum == pageInfo.pageNum}">
			   	 	 	<li class="active"><a href="#">${pageCurrentNum} </a></li>
			   	 	 </c:if>
			   	 	 <c:if test="${pageCurrentNum != pageInfo.pageNum}">
			   	 	 	<li ><a href="${APP_PATH }/emps?pn=${pageCurrentNum}">${pageCurrentNum} </a></li>
			   	 	 </c:if>
			    </c:forEach>
			    <c:if test="${pageInfo.hasNextPage}">
				    <li>
				      <a href="${APP_PATH }/emps?pn=${pageInfo.pageNum + 1}" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
			   		 </li>
			    </c:if>
			    <li><a href="${APP_PATH }/emps?pn=${pageInfo.pages}">尾页</a> </li>
			  </ul>
			</nav>
	  	</div>
	  </div>
	</div>

</body>
</html>