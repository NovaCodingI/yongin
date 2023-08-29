package egovframework.ddan.component;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import egovframework.ddan.mapper.TempMapper;
import egovframework.ddan.service.PointService;
import egovframework.ddan.vo.LocationVo;

@Component
public class AndroidComponent {
	
	
private static final long LOCATION_PROCESSING_INTERVAL = 60000;
	
	@Autowired
	TempMapper mapper;
	
	@Resource(name="pService")
	private PointService pService;
	
//	@Autowired 
//	PointService pService;
	 
	
	@Scheduled(fixedDelay = LOCATION_PROCESSING_INTERVAL)
	@Transactional  // 트랜잭션 추가
	  public void processLocationData() { // 임시 테이블에서 데이터를 포인트 테이블로 이동하고 임시 테이블을 비우는 로직을 구현합니다.
		  
//		try {
		List<LocationVo> list = mapper.getLocaList();
		
		  int res = pService.insertList(list);
		  
		  if(res > 0) {
	    		System.out.println("데이터 이동완료");
//	    		mapper.deleteTemt();  // 데이터가 성공적으로 삽입된 후에만 삭제
	    	}else {
	    		System.out.println("데이터 이동실패");
	    	}
//        } catch (Exception e) {
//            System.out.println("오류 발생: " + e.getMessage());
//            e.printStackTrace();  // 예외 스택 트레이스 출력
//        }
		
		  // 삭제
		  mapper.deleteTemt();
	  
	  }
	
	
}
