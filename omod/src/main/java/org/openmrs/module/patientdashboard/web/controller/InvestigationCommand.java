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

import java.util.List;
import java.util.Set;

import org.openmrs.Encounter;
import org.openmrs.module.patientdashboard.web.controller.global.Node;

public class InvestigationCommand {
	
	
	private Integer patientId;
	private Integer[] tests;
	private String date;
	private List<Encounter> encounters;
	private List<Node> nodes;
	private Set<String> dates;
	public List<Node> getNodes() {
		return nodes;
	}
	public void setNodes(List<Node> nodes) {
		this.nodes = nodes;
	}
	public Integer getPatientId() {
		return patientId;
	}
	public void setPatientId(Integer patientId) {
		this.patientId = patientId;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public List<Encounter> getEncounters() {
		return encounters;
	}
	public void setEncounters(List<Encounter> encounters) {
		this.encounters = encounters;
	}
	public Set<String> getDates() {
		return dates;
	}
	public void setDates(Set<String> dates) {
		this.dates = dates;
	}
	public Integer[] getTests() {
		return tests;
	}
	public void setTests(Integer[] tests) {
		this.tests = tests;
	}
	
}
