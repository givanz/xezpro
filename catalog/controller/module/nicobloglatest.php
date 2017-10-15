<?php
include_once(DIR_APPLICATION . '/controller/module/nicomodule.inc');
global $_nico_module_counter;
class ControllerModuleNicobloglatest  extends NicoModule
{
	protected function easyblog(&$data) 
	{
		if (!file_exists(DIR_APPLICATION . '/model/blog/article.php')) return false;
		$this->load->model('blog/article');
		$this->load->model('tool/image');
        $this->load->language('blog/blog');

		$resize_method = 0;
		if (isset($data['resize_method']) && $data['resize_method'] == 'cropresize')
		{
			$resize_method = 1;
		}

        
        $data['text_readmore'] = $this->language->get('button_read_more');

		$limit = $data['limit'];
		$filter_data = array(
/*			'filter_filter'      => $filter,*/
			'sort'               => 'article_id',
			'order'              => 'DESC',
			'start'              => 0,
			'limit'              => $limit
		);


		$results = $this->model_blog_article->getArticles($filter_data);

		foreach ($results as $result) 
		{
			$result['intro_text'] = html_entity_decode($result['intro_text'], ENT_QUOTES, 'UTF-8');
			$result['intro_text'] = preg_replace_callback('@src=".*/image/([^"]+)"@', function($matches) use ($data, $resize_method)
			{
				if ($resize_method)
				$thumb = $this->model_tool_image->cropsize($matches[1], $data['width'], $data['height'] ); else
				$thumb = $this->model_tool_image->resize($matches[1], $data['width'], $data['height'] );
				
				return 'src="' . $thumb . '"';
			}, $result['intro_text']);
			
			$data['blogs'][] = array(
				'article_id'  => $result['article_id'],
				'name'        => (isset($result['name']))?$result['name']:$result['title'],
				'title'        => (isset($result['title']))?$result['title']:$result['name'],
				'date_modified'  => date($this->language->get('date_format_short'), strtotime($result['date_modified'])),
				'intro_text' => (isset($result['intro_text']))?html_entity_decode($result['intro_text'], ENT_QUOTES, 'UTF-8'):html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'),
				'description' => (isset($result['description']))?html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8'):html_entity_decode($result['intro_text'], ENT_QUOTES, 'UTF-8'),
				'href'        => $this->url->link('blog/article', 'article_id=' . $result['article_id']),
				'url'        => $this->url->link('blog/article', 'article_id=' . $result['article_id'])
			);
		}

		$url = '';
	}

	protected function pavblog(&$data) 
	{
		if (!file_exists(DIR_APPLICATION . '/model/pavblog/blog.php')) return false;
		static $module = 0;
		$this->load->model('pavblog/blog');
		$this->load->model('catalog/product'); 
		$this->load->model('tool/image');
		$this->language->load('module/pavblog');
		
		$data['button_cart'] = $this->language->get('button_cart');
		$data['text_readmore'] = $this->language->get('text_readmore');
		
		$default = array(
			'latest' => 1,
			'limit' => 9
		);
	 
		
		$sql_data = array(
			'sort'  => 'b.`created`',
			'order' => 'DESC',
			'start' => 0,
			'limit' => $data['limit']
		);
		
		$blogs = $this->model_pavblog_blog->getListBlogs( $sql_data );
	
		foreach( $blogs as $key => $blog ){
			if( $blogs[$key]['image'] ){	
				$blogs[$key]['thumb'] = $this->model_tool_image->cropsize($blog['image'], $data['width'], $data['height'] );
			}else {
				$blogs[$key]['thumb'] = '';
			}					
			
			$blogs[$key]['name'] = $blog['title'];
			$blogs[$key]['intro_text'] = html_entity_decode($blog['description'], ENT_QUOTES, 'UTF-8');
			$blogs[$key]['author'] = isset($users[$blog['user_id']])?$users[$blog['user_id']]:$this->language->get('text_none_author');
			$blogs[$key]['category_link'] =  $this->url->link( 'pavblog/category', "path=".$blog['category_id'] );
			$blogs[$key]['comment_count'] =  10;
			$blogs[$key]['href'] =  $this->url->link( 'pavblog/blog','id='.$blog['blog_id'] );
		}
		

		$data['blogs'] = $blogs;
		$data['module'] = $module++;
		
		return $data;

	}
		
	public function index($setting) 
	{
		if (!$this->is_filter_ok($setting)) return false;
		$this->load->model('tool/image');
		$opencart_version = (int)str_replace('.','',VERSION);
		$data = $setting;		

		$lang_code = isset($this->session->data['language'])?$this->session->data['language']:$this->language->get('code');
		
		if (!$lang_code || is_object($lang_code)) $lang_code = $lang_code->get('code');
		
		$lang_code = strtolower($lang_code);

		$default_lang = 'en';

		if ($opencart_version >= 2200)
		{
			$default_lang = 'en-gb';
		}

		global $_nico_module_counter;
		if (isset($_nico_module_counter['nicobloglatest'])) $_nico_module_counter['nicobloglatest']++; else $_nico_module_counter['nicobloglatest'] = 0;
		$data['module_id'] = $_nico_module_counter['nicobloglatest'];
		
		switch ($data['blog'])
		{
			case 'pavblog':
			$this->pavblog($data);
			break;
			
			case 'easyblog':
			$this->easyblog($data);
			break;

			case 'simpleblog':
			$this->simpleblog($data);
			break;
		}
		
		if (isset($setting['title'][$lang_code])) $title = $setting['title'][$lang_code];else if (isset($setting['title'][$default_lang])) $title = $setting['title'][$default_lang];else $title = '';
		$data['title'] = $title;
		
		return $this->_render('nicobloglatest', $data);
	}
}
