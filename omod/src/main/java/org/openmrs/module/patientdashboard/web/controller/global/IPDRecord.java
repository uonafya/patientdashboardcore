/**
 * The contents of this file are subject to the OpenMRS Public License
 * Version 1.0 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://license.openmrs.org
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * Copyright (C) OpenMRS, LLC.  All Rights Reserved.
 **/

package org.openmrs.module.patientdashboard.web.controller.global;

import java.util.Date;
import java.util.List;
import java.util.Set;

import org.openmrs.module.hospitalcore.model.OpdDrugOrder;



public class IPDRecord {
	
	private static final String HOSPITAL_NAME = "Hospital";
	private Integer id;
	private String hospitalName = HOSPITAL_NAME;
	private Date admissionDate;
	private Date dischargeDate;
	private String diagnosis;
	private String procedures;
	private String admissionOutcome;
	private String dischargeSummaryLink;
	public List<OpdDrugOrder> subDetails;
	
	public List<OpdDrugOrder> getSubDetails() {
		return subDetails;
	}

	public void setSubDetails(List<OpdDrugOrder> subDetails) {
		this.subDetails = subDetails;
	}

	public String getHospitalName() {
		return hospitalName;
	}

	public void setHospitalName(String hospitalName) {
		this.hospitalName = hospitalName;
	}

	public Date getAdmissionDate() {
		return admissionDate;
	}

	public void setAdmissionDate(Date admissionDate) {
		this.admissionDate = admissionDate;
	}

	public Date getDischargeDate() {
		return dischargeDate;
	}

	public void setDischargeDate(Date dischargeDate) {
		this.dischargeDate = dischargeDate;
	}

	public String getDiagnosis() {
		return diagnosis;
	}

	public void setDiagnosis(String diagnosis) {
		this.diagnosis = diagnosis;
	}

	public String getProcedures() {
		return procedures;
	}

	public void setProcedures(String procedures) {
		this.procedures = procedures;
	}

	public String getAdmissionOutcome() {
		return admissionOutcome;
	}

	public void setAdmissionOutcome(String admissionOutcome) {
		this.admissionOutcome = admissionOutcome;
	}

	public String getDischargeSummaryLink() {
		return dischargeSummaryLink;
	}

	public void setDischargeSummaryLink(String dischargeSummaryLink) {
		this.dischargeSummaryLink = dischargeSummaryLink;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

}
