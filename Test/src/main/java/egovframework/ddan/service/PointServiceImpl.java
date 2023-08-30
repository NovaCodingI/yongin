package egovframework.ddan.service;

import java.util.List;

import javax.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.ddan.mapper.PointMapper;
import egovframework.ddan.vo.LocationVo;

@Service("pService")
public class PointServiceImpl extends EgovAbstractServiceImpl implements PointService{

	@Resource(name="pMapper")
	private PointMapper pMapper;
	
	@Override
	public int insertList(List<LocationVo> list) {
		
		int insertRes = 0;
		
		System.out.println("원본 리스트 출력 =================" + list);
		
		for(LocationVo testlist : list) {
				System.out.println("리스트 반복 출력 ~~~~~~~~~~~~~" + testlist.toString());
				System.out.println("Before Inserting to Point: " + testlist.getAndroid_id());
			int res = pMapper.insertList(testlist);
			System.out.println("res값 ~~~~~~~~~~~~~" + res);
			if(res > 0) {
				insertRes++;
			}
		}
		
		return insertRes;
	}
	
	

}
