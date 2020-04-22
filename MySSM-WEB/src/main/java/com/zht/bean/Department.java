package com.zht.bean;

public class Department {
    private Integer deptId;

    private String depName;

    
    
    public Department() {
		super();
	}

	public Department(Integer deptId, String depName) {
		super();
		this.deptId = deptId;
		this.depName = depName;
	}

	

    public Integer getDeptId() {
		return deptId;
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

	public String getDepName() {
        return depName;
    }

    public void setDepName(String depName) {
        this.depName = depName == null ? null : depName.trim();
    }
}