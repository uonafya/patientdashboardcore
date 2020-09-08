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
--%> 
<%@ include file="/WEB-INF/template/include.jsp" %>
<select size="15" id="availableDrugList" name="availableDrugList" multiple="multiple" style="min-width:25em;height:20em" ondblclick="moveSelectedById( 'availableDrugList', 'selectedDrugList')">
    <c:if test="${not empty  drugs}">
		<c:forEach items="${drugs}" var="drg">
           <option value="${drg.id}" >${drg.name}</option>
       </c:forEach>
	</c:if>    
</select>