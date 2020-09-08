 <%--
 * * The contents of this file are subject to the OpenMRS Public License
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
 *
--%>
<%@page import="org.openmrs.ConceptName" %>
<%@ include file="/WEB-INF/template/include.jsp" %>
<openmrs:require privilege="View PatientDashboard" otherwise="/login.htm" redirect="index.htm" />
<%@ include file="/WEB-INF/template/header.jsp" %>
<%@ include file="includes/js_css.jsp" %>
<input type="hidden" id="pageId" value="patientDashboard"/>

<b class="boxHeader">Dashboard</b>
<div  class="box">
<table  cellspacing="10" width="100%">
	<tr>
		<td width="40%"><b>Patient ID:</b> ${patient.patientIdentifier.identifier}</td>
		<td width="30%">
				<span style="background-color:red; color:white">Dead Patient</span>				
		</td>
		<td width="30%"><b>Location:</b> ${opd.name } </td>
	</tr>
	<tr>
		<td width="40%"><b>Name:</b> ${patient.givenName}&nbsp;&nbsp;${patient.middleName}&nbsp;&nbsp; ${patient.familyName}</td>
		<td width="30%"><b>Age:</b> ${age }</td>
		<td width="30%"><b>Gender:</b> ${patient.gender }</td>
	</tr>
	<tr>
		<td width="40%"><b>Patient category:</b> ${patientCategory} -
		<c:forEach items="${observation}" var="observation">
			${observation.valueText} 
		</c:forEach>
		</td>
		<td width="30%"><b>Age category:</b> ${ageCategory }</td>
		<td width="30%"><b>Referral:</b>
		<c:choose> 
				<c:when test="${referredType.class.name == 'org.openmrs.ConceptName'}">
					${referredType}
				</c:when>
				<c:otherwise>
					${referral.name }	
				</c:otherwise>
			</c:choose>
		</td>
		
	</tr>
</table>
<div id="tabs">
     <ul>
         <li><a href="clinicalSummary.htm?patientId=${patient.patientId }"   title="Clinical summary"><span>Clinical summary</span></a></li>
         <li><a href="investigationReport.htm?patientId=${patient.patientId }"  title="Laboratory record"><span >Laboratory record</span></a></li>
         <li><a href="radiologyRecord.htm?patientId=${patient.patientId }" title="Radiology record"><span>Radiology record</span> </a></li>
         <li><a href="ipdRecord.htm?patientId=${patient.patientId }&opdLog=${opdLog}"  title="IPD record"><span >IPD record</span></a></li>
		 <li><a href="pharmacyRecord.htm?patientId=${patient.patientId }" title="Pharmacy record"><span>Pharmacy record</span> </a></li>
     </ul>
     
	 <div id="Clinical_summary"></div>
	 <div id="Laboratory_record"></div>
	 <div id="Radiology_record"></div>
	 <div id="IPD_record"></div>
	 <div id="Pharmacy_record"></div>
</div>

</div>


<%@ include file="/WEB-INF/template/footer.jsp" %> 