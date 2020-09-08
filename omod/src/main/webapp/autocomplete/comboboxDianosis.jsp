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
<%@ include file="/WEB-INF/template/include.jsp" %>
<select size="15" id="availableDiagnosisList" name="availableDiagnosisList" multiple="multiple" style="min-width:25em;height:20em" ondblclick="moveSelectedById( 'availableDiagnosisList', 'selectedDiagnosisList')">
    <c:if test="${not empty  diagnosis}">
		<c:forEach items="${diagnosis}" var="dia">
           <option value="${dia.id}" >${dia.name}</option>
       </c:forEach>
	</c:if>    
</select>