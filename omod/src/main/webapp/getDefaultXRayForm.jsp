 <%--
 *  * The contents of this file are subject to the OpenMRS Public License
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
<script type="text/javascript">
	jQuery(document).ready(function(){		
		fillData();
	});
	
	// set input value
	function setInputValue(name, value, testId){		
		
		jQuery("#form_content_" + testId + " input[name=" + name + "]").each(function(index){
			input = jQuery(this);
			if(input.attr("type")=="radio"){
				if(input.attr("value")==value){
					input.attr("checked", "checked");
				};
			} else {
				input.val(value);
			}
		});
		
		jQuery("#form_content_" + testId + " select[name="+ name + "]").each(function(index){
			select = jQuery(this);			
			jQuery("option", select).each(function(index){
				option = jQuery(this);				
				if(option.attr("value")==value){
					option.attr("selected", "selected");
				}
			});
		});
		
		jQuery("#form_content_" + testId + " textarea[name="+ name + "]").each(function(index){
			textarea = jQuery(this);
			jQuery("textarea").html(value);
		});
	}
	
	// Fill data into all inputs
	function fillData(){
		<c:if test="${not empty inputNames}">
			<c:forEach var="i" begin="0" end="${inputLength-1}" step="1">
				setInputValue("${inputNames[i]}", "${inputValues[i]}", ${testId});
			</c:forEach>
		</c:if>		
	}		
</script>

<input type="hidden" name="encounterId" value="${encounterId}"/>	
<div id="form_content_${testId}">	
	${form.content}
</div>

<c:if test="${mode eq 'edit'}">	 
	<input type="button" value="Cancel" onClick="tb_remove();"/>
</c:if>