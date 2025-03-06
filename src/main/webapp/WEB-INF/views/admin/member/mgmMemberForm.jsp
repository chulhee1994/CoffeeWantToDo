<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>  
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath"  value="${pageContext.request.contextPath}"  />
<%
  request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
function delMember(mem_id) {
    if (confirm("연관된 모든 저장소의 회원 정보가 삭제됩니다.\n정말 삭제하시겠습니까 ??")) {
        $.ajax({
            url: "${contextPath}/admin/member/delMemgrade.do",
            type: "POST",
            contentType: "application/json",  // 요청 데이터 타입을 JSON으로 설정
            data: JSON.stringify({  // 데이터를 JSON 형식으로 변환
                "mem_id": mem_id,
            }),
            success: function(data, textStatus, xhr) {
                // 서버에서 보내주는 응답이 JSON 형식이라면 아래처럼 처리
                if (data.success) {
                    alert("삭제 완료되었습니다.");
                    document.location.reload(true);
                } else {
                    alert("삭제 실패: " + data.message);
                }
                console.log(data);
            },
            error: function(xhr, status, error) {
                console.log(error);
                alert("삭제 실패");
            }
        });
    } else {
        // 취소하면 아무 것도 하지 않음
    }
}
    
 // select 값에 따라 mem_grade 변경
    function selectBoxChange(mem_id, mem_grade) {
    if (confirm("회원 등급을 변경 하시겠습니까?")) {
        $.ajax({
            url: "${contextPath}/admin/member/modMemgrade.do",
            type: "POST",
            contentType: "application/json",  // 요청 데이터 타입을 JSON으로 설정
            data: JSON.stringify({  // 데이터를 JSON 형식으로 변환
                "mem_id": mem_id,
                "mem_grade": mem_grade
            }),
            success: function(data, textStatus, xhr) {
                // 서버에서 보내주는 응답이 JSON 형식이라면 아래처럼 처리
                if (data.success) {
                    alert("변경 완료되었습니다.");
                    document.location.reload(true);
                } else {
                    alert("변경 실패: " + data.message);
                }
                console.log(data);
            },
            error: function(xhr, status, error) {
                console.log(error);
                alert("변경 실패");
            }
        });
    } else {
        // 취소하면 아무 것도 하지 않음
    }
}

 // select 값에 따라 mem_del_yn 변경
    function selectBoxChange_delyn (mem_id, mem_del_yn) {
    if (confirm("탈퇴 여부를 변경 하시겠습니까 ??")) {
        $.ajax({
            url: "${contextPath}/admin/member/modMemdelyn.do",
            type: "POST",
            contentType: "application/json",  // 요청 데이터 타입을 JSON으로 설정
            data: JSON.stringify({  // 데이터를 JSON 형식으로 변환
                "mem_id": mem_id,
                "mem_del_yn": mem_del_yn
            }),
            success: function(data, textStatus, xhr) {
                // 서버에서 보내주는 응답이 JSON 형식이라면 아래처럼 처리
                if (data.success) {
                    alert("변경 완료되었습니다.");
                    document.location.reload(true);
                } else {
                    alert("변경 실패: " + data.message);
                }
                console.log(data);
            },
            error: function(xhr, status, error) {
                console.log(error);
                alert("변경 실패");
            }
        });
    } else {
        // 취소하면 아무 것도 하지 않음
    }
}

</script>
<link rel="stylesheet" href="${contextPath}/resources/css/admin/mgmMember/mgmMember.css">
<!-- 메타 태그 추가 (뷰포트 설정) -->
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- 부트스트랩 CSS 추가 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<title>회원 관리 페이지</title>
</head>
<body>
    <div class="header">
    	<%@ include file="../../common/header.jsp" %>
    </div>
<div class="container">
<h2 class="ct2-title">회원 목록</h2>
       <div class="table-responsive">
          <table class="table table-striped">
              <thead style="background-color: #D2B48C;">
                  <tr>
                  	  <th class="text-center">번호</th>
                      <th class="text-center">회원ID</th>
                      <th class="text-center">회원이름</th>
                      <th class="text-center">회원등급</th>
                      <th class="text-center">탈퇴여부</th>
                      <th class="text-center">삭제</th>
                  </tr>
              </thead>
              <tbody>
                  <c:choose>
                     <c:when test="${empty membersList}">
						<h3 class="text-gray">조회된 회원 목록이 없습니다.</h3>
                     </c:when>
                      <c:otherwise>
                          <c:forEach var="members" items="${membersList}" varStatus="status">
                          <tr>
                            <td class="text-center"><strong>${status.index + 1}</strong></td>
                            <td class="text-center"><strong>${members.mem_id}</strong></td>                           
                            <td class="text-center"><strong>${members.mem_name}</strong></td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${members.mem_grade == 'common'}">
                                        <select name="mem_grade_${members.mem_id}" id="mem_grade_${members.mem_id}" onchange="selectBoxChange('${members.mem_id}',this.value);" style="text-align: center;">
                                            <option value="common" selected>common</option>                                          
                                            <option value="seller">seller</option>
                                            <option value="admin">admin</option>
                                        </select>
                                    </c:when>
                                    <c:when test="${members.mem_grade == 'kakao'}">
                                    	<select name="mem_grade_${members.mem_id}" id="mem_grade_${members.mem_id}" onchange="selectBoxChange('${members.mem_id}',this.value);" style="text-align: center;">
                                       		<option value="kakao" selected>kakao</option>
                                    	</select>
                                    </c:when>
                                    <c:when test="${members.mem_grade == 'seller'}">
                                        <select name="mem_grade_${members.mem_id}" id="mem_grade_${members.mem_id}" onchange="selectBoxChange('${members.mem_id}',this.value);" style="text-align: center;">
                                            <option value="common">common</option>                                           
                                            <option value="seller" selected>seller</option>
                                        </select>
                                    </c:when>
                                </c:choose>
                            </td>
                            <td class="text-center">
                            <c:choose>
                            <c:when test="${members.mem_del_yn == 'Y'}">
                            <select name="mem_del_yn_${members.mem_del_yn}" id="mem_del_yn_${members.mem_del_yn}" onchange="selectBoxChange_delyn('${members.mem_id}',this.value);" style="text-align: center;">
                                            <option value="Y" selected>Y</option>                                           
                                            <option value="N">N</option>
                            </select>
                             </c:when>
                             <c:when test="${members.mem_del_yn == 'N'}">
                            <select name="mem_del_yn_${members.mem_del_yn}" id="mem_del_yn_${members.mem_del_yn}" onchange="selectBoxChange_delyn('${members.mem_id}',this.value);" style="text-align: center;">
                                            <option value="Y" >Y</option>                                           
                                            <option value="N" selected>N</option>
                            </select>
                             </c:when>
                             </c:choose>           
                             </td>                                                           
                            <td class="text_center">
                                <a href="javascript:void(0);" class="btn-custom" onclick="delMember('${members.mem_id}');">삭제</a>
                            </td>
                          </tr>
                          </c:forEach>
                      </c:otherwise>
                  </c:choose>
              </tbody>
          </table>
       </div>
       </div>
    <div class="footer">
    	<%@ include file="../../common/footer.jsp" %>
    </div>
</body>
</html>
