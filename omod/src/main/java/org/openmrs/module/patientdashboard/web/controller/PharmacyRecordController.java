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

package org.openmrs.module.patientdashboard.web.controller;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;
import org.openmrs.Patient;
import org.openmrs.api.PatientService;
import org.openmrs.api.context.Context;
import org.openmrs.module.hospitalcore.InventoryCommonService;
import org.openmrs.module.hospitalcore.model.InventoryStoreDrugPatient;
import org.openmrs.module.hospitalcore.model.InventoryStoreDrugPatientDetail;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller("PharmacyRecordController")
@RequestMapping("/module/patientdashboard/pharmacyRecord.htm")
public class PharmacyRecordController {

	@RequestMapping(method = RequestMethod.GET)
	public String firstView(
			@RequestParam(value = "patientId", required = false) Integer patientId,
			Model model) {
		InventoryCommonService inventoryCommonService = (InventoryCommonService) Context
				.getService(InventoryCommonService.class);
		PatientService patientService = (PatientService) Context
				.getService(PatientService.class);
		Patient patient = patientService.getPatient(patientId);
		List<InventoryStoreDrugPatient> listDate = inventoryCommonService
				.getAllIssueDateByPatientId(patient);
		//ghanshyam,date:25-april-2013 Feedback #1391 Add Pharmacy record of patient in Dashboard(written below LinkedHashSet at the place of HashSet)
		Set<String> dates = new LinkedHashSet<String>();
		for (InventoryStoreDrugPatient date : listDate) {
			dates.add(Context.getDateFormat().format(date.getCreatedOn()));
		}
		model.addAttribute("patientId", patientId);
		model.addAttribute("dates", dates);
		return "module/patientdashboard/pharmacyRecord";
	}

	@RequestMapping(method = RequestMethod.POST)
	public String formSubmit(
			@RequestParam(value = "patientId", required = false) Integer patientId,
			@RequestParam(value = "date", required = false) String date,Model model) {
		InventoryCommonService inventoryCommonService = (InventoryCommonService) Context
				.getService(InventoryCommonService.class);
		PatientService patientService = (PatientService) Context
				.getService(PatientService.class);
		if(!date.equals("null")){
		Patient patient = patientService.getPatient(patientId);
		List<InventoryStoreDrugPatient> listIssue = inventoryCommonService
				.getDeatilOfInventoryStoreDrugPatient(patient, date);
		List<InventoryStoreDrugPatientDetail> drugDetails = new ArrayList<InventoryStoreDrugPatientDetail>();
		for (InventoryStoreDrugPatient isdpd : listIssue) {
			List<InventoryStoreDrugPatientDetail> listDrugIssue = inventoryCommonService
					.getDrugDetailOfPatient(isdpd);
			drugDetails.addAll(listDrugIssue);
		}
		model.addAttribute("drugDetails", drugDetails);
		}
		return "module/patientdashboard/pharmacyRecordResult";
	}
}
