
<%--
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
 *
--%>
<%@ include file="/WEB-INF/template/include.jsp"%>
<%@ include file="/WEB-INF/template/headerMinimal.jsp"%>
<link type="text/css" rel="stylesheet"
	href="${pageContext.request.contextPath}/moduleResources/patientdashboard/styles/common.css" />
<span class="boxHeader">Vital Statistics Details</span>
<table class="box">
	<tr>
		<td><strong>Weight (Kg)</strong></td>
		<td>${weight}</td>
	</tr>
	<tr>
		<td><strong>Height (cm)</strong></td>
		<td>${height}</td>
	</tr>
	<tr>
		<td><strong>BMI</strong></td>
		<td>${bmi}</td>
	</tr>
   <tr>
		<td><strong>Temperature(F)</strong></td>
		<td>${temp}</td>
	</tr>
	<tr>
		<td><strong>B.P</strong></td>
		<td><c:choose>
		<c:when test="${not empty sbp && not empty dbp}">
		${sbp}/${dbp}
		</c:when>
		<c:otherwise>
		<td></td>
		</c:otherwise>
		</c:choose></td>
	</tr>
	
	<tr>
		<td><strong>Pulse Rate(/min)</strong></td>
		<td>${pulserate}</td>
	</tr>
	<tr>
		<td><strong>LMP</strong></td>
		<td>${lmp}</td>
	</tr>
</table>
