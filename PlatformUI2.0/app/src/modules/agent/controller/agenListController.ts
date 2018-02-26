/*******************************************************************************
 * Copyright 2017 Cognizant Technology Solutions
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not
 * use this file except in compliance with the License.  You may obtain a copy
 * of the License at
 * 
 *   http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
 * WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
 * License for the specific language governing permissions and limitations under
 * the License.
 ******************************************************************************/

module ISightApp {
    export class AgentListController {
        static $inject = ['agentService', 'iconService', '$sce', 'NgTableParams', '$mdDialog', '$cookies', 'toolConfigService'];
        constructor(			
            private agentService: IAgentService,
            private iconService: IIconService,
			private $sce, private NgTableParams,
            private $mdDialog, private $cookies, private toolConfigService: IToolConfigService) {
			
			var elem = document.querySelector('#homePageTemplateContainer');
            var homePageControllerScope = angular.element(elem).scope();
            var homePageController = homePageControllerScope['homePageController'];
            this.homeController = homePageController;
            var self = this;				
			
			self.homeController.templateName = 'agentList';
			self.data = [
				{'os': 'windows', 'toolName': "JIRA", 'Version': 'v4.0', 'Status':'live'},
				{'os': 'windows','toolName': "Jenkins", 'Version': 'v4.1', 'Status':'live'},
				{'os': 'linux','toolName': "Rally", 'Version': 'v3.0', 'Status':'live'},
				{'os': 'windows','toolName': "Sonar", 'Version': 'v4.5', 'Status':'live'},
				{'os': 'windows','toolName': "Rundeck", 'Version': 'v3.5', 'Status':'live'},
				{'os': 'linux','toolName': "Git", 'Version': 'v3.0', 'Status':'live'},
				];
			self.showAgentListtable();
			
		}
		data = [];
		tableParams = [];
		homeController: HomePageController;
		buttonDisableStatus: boolean = true;
	    editIconSrc: string = "dist/icons/svg/actionIcons/Edit_icon_disabled.svg";
    	
		showAgentListtable(): void {
			this.tableParams = new this.NgTableParams({count: 5}, { dataset: this.data});
		}
		
		editAgentConfigurations(params): void {				
			this.homeController.selectedAgentTooldetails = params;            
			this.homeController.templateName = 'agentManagement';			
		}
		
		enableActions(): void{		
            this.buttonDisableStatus = false;
			this.editIconSrc = "dist/icons/svg/userOnboarding/Edit_icon_MouseOver.svg";
		}
		
	}
	
}