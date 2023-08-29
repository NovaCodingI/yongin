package egovframework.ddan.service;

import java.util.List;

import org.springframework.stereotype.Service;

import egovframework.ddan.vo.LocationVo;


public interface PointService {
	
	
	public int insertList(List<LocationVo> list);
}
