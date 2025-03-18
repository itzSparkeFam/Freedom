import{d as se,a as E,c as et,p as tt,b as at,u as V,e as te,r as f,j as e,B as it,M as st,S as Pe,f as qe,I as nt,T as Ie,g as Te,h as rt,i as Ye,D as ot,k as lt,F as Ue,R as je,C as K,l as De,A as ct,X as dt,Y as pt,m as gt,n as mt,o as ut,q as ht,s as ft,t as bt,v as xt,H as yt,w as Ct,x as vt,y as kt,z as Nt,E as wt,G as jt,J as Ae,K as It,L as Pt,N as St}from"./vendor-CQisilH4.js";(function(){const i=document.createElement("link").relList;if(i&&i.supports&&i.supports("modulepreload"))return;for(const s of document.querySelectorAll('link[rel="modulepreload"]'))c(s);new MutationObserver(s=>{for(const g of s)if(g.type==="childList")for(const j of g.addedNodes)j.tagName==="LINK"&&j.rel==="modulepreload"&&c(j)}).observe(document,{childList:!0,subtree:!0});function r(s){const g={};return s.integrity&&(g.integrity=s.integrity),s.referrerPolicy&&(g.referrerPolicy=s.referrerPolicy),s.crossOrigin==="use-credentials"?g.credentials="include":s.crossOrigin==="anonymous"?g.credentials="omit":g.credentials="same-origin",g}function c(s){if(s.ep)return;s.ep=!0;const g=r(s);fetch(s.href,g)}})();const ve=()=>!window.invokeNative,Lt=()=>{},ne=t=>{var i;return(i=t==null?void 0:t.toFixed(2))==null?void 0:i.replace(/\B(?=(\d{3})+(?!\d))/g,",")},ee=(t,i)=>i==null?void 0:i.replace("{amount}",t==null?void 0:t.toString()),Je=(t,i)=>se(t).format(i),We=t=>new Promise((i,r)=>{fetch(`locales/${t}.json`).then(c=>c.json()).then(c=>i(c)).catch(c=>r(c))});var de=(t=>(t.Open="open",t.Closed="closed",t.Closing="closing",t))(de||{}),J=(t=>(t.Open="open",t.Closed="closed",t.Closing="closing",t))(J||{}),ye=(t=>(t.Oldest="oldest",t.Newest="newest",t.AmountAsc="amountAsc",t.AmountDesc="amountDesc",t))(ye||{}),h=(t=>(t.All="all",t.Paid="paid",t.Unpaid="unpaid",t.Rejected="rejected",t.Cancelled="cancelled",t.Recurring="recurring",t.NotAccepted="not_accepted",t))(h||{}),Y=(t=>(t.Personal="__personal",t.Society="society",t))(Y||{}),re=(t=>(t.Open="open",t.Closed="closed",t.Closing="closing",t))(re||{}),D=(t=>(t.Personal="personal",t.Business="business",t))(D||{});const $t={UIVisible:!1,setUIVisible:E((t,i)=>{t.UIVisible=i}),acceptInvoiceVisible:!1,setAcceptInvoiceVisible:E((t,i)=>{t.acceptInvoiceVisible=i}),totalInvoices:0,setTotalInvoices:E((t,i)=>{t.totalInvoices=i}),invoices:[],setInvoices:E((t,i)=>{t.invoices=i}),companyConfig:null,setCompanyConfig:E((t,i)=>{t.companyConfig=i}),jobInfo:null,setJobInfo:E((t,i)=>{t.jobInfo=i}),playerData:null,setPlayerData:E((t,i)=>{t.playerData=i}),menuType:D.Personal,setMenuType:E((t,i)=>{t.menuType=i}),createInvoiceModalOpen:re.Closed,setCreateInvoiceModalOpen:E((t,i)=>{t.createInvoiceModalOpen=i}),viewInvoice:null,setViewInvoice:E((t,i)=>{t.viewInvoice=i}),viewInvoiceModalOpen:J.Closed,setViewInvoiceModalOpen:E((t,i)=>{t.viewInvoiceModalOpen=i}),settingsConfig:{language:"en",showFullName:!0,allowOverdraft:!1,overdraftLimit:0,currencyFormat:"{amount}$",currencySymbol:"$",dateFormat:"DD-MM-YYYY",highlightNewInvoiceDuration:10,dateTimeFormat:"DD-MM-YYYY HH:mm",societyFilters:[]},setSettingsConfig:E((t,i)=>{t.settingsConfig=i}),filters:{status:h.All,society:"all",orderBy:ye.Newest,type:Y.Personal,dateRange:{dateFrom:"",dateTo:""}},setFilters:E((t,i)=>{t.filters=i}),appSettings:{appSize:1,confirmCancel:!0,confirmPayment:!0},setAppSettings:E((t,i)=>{t.appSettings=i}),flexOasisData:{status:!1},setFlexOasisData:E((t,i)=>{t.flexOasisData=i}),hasNewInvoice:!1,setHasNewInvoice:E((t,i)=>{t.hasNewInvoice=i}),mugshot:"",setMugshot:E((t,i)=>{t.mugshot=i}),customModal:null,setCustomModal:E((t,i)=>{t.customModal=i}),statisticsOpen:de.Closed,setStatisticsOpen:E((t,i)=>{t.statisticsOpen=i}),settingsDrawerOpen:!1,setSettingsDrawerOpen:E((t,i)=>{t.settingsDrawerOpen=i}),resizeBy:1,setResizeBy:E((t,i)=>{t.resizeBy=i})},Bt=et(tt($t,{storage:"sessionStorage"}),{name:"tgg-billing-store"});var O=(t=>(t.Create="create",t.Dashboard="dashboard",t.Details="details",t.Accept="accept",t))(O||{});const Ge=at(),q=Ge.useStoreActions,v=Ge.useStoreState,qt=V.div.attrs({className:"tgg-invoice-details"})`
	position: relative;

	display: flex;
	flex-direction: column;

	gap: 0.5em;

	height: 100%;
	width: 100%;

	padding: 1.25em 0.75em 1em 0.75em;

	z-index: 2;

	.tgg-highlight-new {
		display: flex;
		justify-content: center;
		align-items: center;
		color: #ffffff;

		width: 50px;
		height: 25px;
		background-color: #00c91b;

		border-radius: 5px;

		position: absolute;

		top: -0.4em;
		left: -0.75em;

		transform: rotate(-35deg);
	}

	.tgg-invoice-header {
		.tgg-invoice-subtitle {
			font-size: 0.85em;
			font-weight: 600;
			text-align: start;
		}
	}

	.tgg-invoice-body-wrapper {
		display: flex;
		flex-direction: column;
		gap: 0.25em;

		.tgg-invoice-row {
			display: flex;
			justify-content: space-between;

			.tgg-invoice-label {
				font-size: 0.8em;
				color: #000;
				font-weight: 600;

				text-align: start;
			}

			.tgg-invoice-value {
				font-size: 0.8em;
				color: #000;

				text-align: end;
			}
		}

		.tgg-notes {
			display: flex;
			flex-direction: column;

			.tgg-invoice-label {
				font-size: 0.8em;
				color: #000;
				font-weight: 600;
				text-align: start;
				height: 1em;
				line-height: 1em;
			}

			.tgg-invoice-value {
				font-size: 0.8em;
				color: #000;
				text-align: start;

				height: 2em;
				line-height: 1em;

				overflow: hidden auto;
			}
		}

		.tgg-divider-dashed {
			height: 1px;
			width: 100%;
			border-top: 2px dashed rgba(97, 97, 97, 0.5);
			margin: 0.35em 0;
		}

		.tgg-invoice-items-container {
			padding: 0.25em 0;

			> div:first-child {
				padding-bottom: 0.25em;
			}

			.tgg-invoice-items-wrapper {
				display: flex;
				flex-direction: column;
				gap: 0.25em;

				width: 100%;
				height: 4.5em;

				overflow-y: auto;
				overflow-x: hidden;

				padding-right: 0.25em;

				&.tgg-longer-view {
					height: 7.5em;
				}

				.tgg-invoice-row {
					display: flex;
					justify-content: space-between;

					.tgg-invoice-label {
						font-size: 0.8em;
						color: #000;
						font-weight: 600;
					}

					.tgg-items-label {
						text-decoration: underline;
					}

					.tgg-invoice-value {
						font-size: 0.8em;
						color: #000;
					}
				}
			}
		}
	}

	${({$invoiceLocation:t})=>(t===O.Details||t===O.Accept)&&`
		.tgg-invoice-subtitle {
			font-size: 1.2em !important;
		}

		.tgg-notes {
			height: 4.5em !important;

			.tgg-invoice-value {
				height: 100% !important;
			} 
		}

		.tgg-invoice-value {
			font-size: 0.9em !important;
		}

		.tgg-invoice-label {
			font-size: 0.95em !important;
		}

		.tgg-invoice-items-container {
			.tgg-items-label {
				font-size: 0.95em !important;
			}

			.tgg-invoice-items-wrapper {
				height: 15em !important;
			}

			.tgg-invoice-label {
				font-size: 0.85em !important;
			}

			.tgg-invoice-value {
				font-size: 0.85em !important;
			}
		}
	`}

	.tgg-scrollbar-style {
		::-webkit-scrollbar {
			width: 3px;
			height: 3px;
		}

		::-webkit-scrollbar-button {
			width: 0px;
			height: 0px;
		}

		::-webkit-scrollbar-thumb {
			background: #e1e1e1;
			border: 0px none red;
			border-radius: 50px;
		}

		::-webkit-scrollbar-thumb:hover {
			background: #bdbdbd;
		}

		::-webkit-scrollbar-thumb:active {
			background: #909090;
		}

		::-webkit-scrollbar-track {
			background: #ffffff;
			border: 0px none #ffffff;
			border-radius: 50px;
		}

		::-webkit-scrollbar-track:hover {
			background: #cacaca;
		}

		::-webkit-scrollbar-track:active {
			background: #cacaca;
		}

		::-webkit-scrollbar-corner {
			background: transparent;
		}
	}
`,Qe=({invoice:t,invoiceLocation:i})=>{var l;const{t:r}=te(),[c,s]=f.useState(0),[g,j]=f.useState(0),[y,d]=f.useState(0),N=v($=>$.settingsConfig),x=N.dateTimeFormat,_=N.currencySymbol,I=N.currencyFormat;f.useEffect(()=>{u()},[t]);const u=()=>{var A;let $=0,w=0,k=0;(A=t==null?void 0:t.items)==null||A.forEach(n=>{$+=n.price*n.quantity}),w=$*(t.taxPercentage/100),k=$+w,s($),d(w),j(k)};return e.jsxs(qt,{$invoiceLocation:i,children:[e.jsx("div",{className:"tgg-invoice-header",children:e.jsx("div",{className:"tgg-invoice-subtitle",children:t.senderCompanyName?t.senderCompanyName:r("invoice.personalInovice")})}),e.jsxs("div",{className:"tgg-invoice-body-wrapper",children:[e.jsxs("div",{className:"tgg-invoice-row",children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.status"),":"]}),e.jsx("div",{className:"tgg-invoice-value",children:r(`invoice.${t.status}Status`)})]}),e.jsxs("div",{className:"tgg-invoice-row",children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.date"),":"]}),e.jsx("div",{className:"tgg-invoice-value",children:Je(t.timestamp,x)})]}),e.jsxs("div",{className:"tgg-invoice-row",children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.from"),":"]}),e.jsx("div",{className:"tgg-invoice-value",children:t.senderName})]}),e.jsxs("div",{className:"tgg-invoice-row",children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.to"),":"]}),e.jsx("div",{className:"tgg-invoice-value",children:N.showFullName?t.recipientName:r("general.hidden")})]}),e.jsxs("div",{className:"tgg-invoice-items-container",children:[e.jsx("div",{className:"tgg-invoice-row",children:e.jsxs("div",{className:"tgg-invoice-label tgg-items-label",children:[r("invoice.items"),":"]})}),e.jsx("div",{className:`tgg-invoice-items-wrapper tgg-scrollbar-style${t.notes?"":" tgg-longer-view"}`,children:(l=t==null?void 0:t.items)==null?void 0:l.map(($,w)=>e.jsxs("div",{className:"tgg-invoice-row",children:[e.jsx("div",{className:"tgg-invoice-label",children:$.label}),e.jsxs("div",{className:"tgg-invoice-value",children:[$.quantity," x ",_,$.price.toFixed(2)]})]},w))})]}),e.jsx("div",{className:"tgg-invoice-row tgg-notes",children:t.notes&&e.jsxs(e.Fragment,{children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.notes"),":"]}),e.jsx("div",{className:"tgg-invoice-value tgg-scrollbar-style",children:t.notes})]})}),e.jsx("div",{className:"tgg-divider-dashed"}),e.jsxs("div",{className:"tgg-invoice-row",children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.subTotal"),":"]}),e.jsx("div",{className:"tgg-invoice-value",children:ee(ne(c),I)})]}),e.jsxs("div",{className:"tgg-invoice-row",children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.vat"),"(",t.taxPercentage,"%):"]}),e.jsx("div",{className:"tgg-invoice-value",children:ee(ne(y),I)})]}),e.jsxs("div",{className:"tgg-invoice-row",children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.total"),":"]}),e.jsx("div",{className:"tgg-invoice-value",children:ee(ne(g),I)})]})]})]})};var Ze=(t=>(t[t.ConfirmPayment=0]="ConfirmPayment",t[t.ConfirmCancel=1]="ConfirmCancel",t))(Ze||{});const P=(t,i)=>{t=t.replace("#",""),t.length===3&&(t=t.split("").map(g=>g+g).join(""));const r=parseInt(t.substr(0,2),16),c=parseInt(t.substr(2,2),16),s=parseInt(t.substr(4,2),16);return`rgba(${r}, ${c}, ${s}, ${i})`},p={p50:"#f1f7fe",p100:"#e2eefc",p200:"#bedcf9",p300:"#84bff5",p400:"#429eee",p500:"#1e88e5",p600:"#0c65bd",p700:"#0b5199",p800:"#0e457e",p900:"#113b69",p950:"#0b2546",s50:"#f6f5fd",s100:"#efecfb",s200:"#dfdbf9",s300:"#c7bef4",s400:"#ac99ec",s500:"#9070e2",s600:"#7e51d6",s700:"#673ab7",s800:"#5c34a3",s900:"#4c2d85",s950:"#2f1b5a",background:"#161a2f",secondaryBackground:"#0f1327",blue600:"#0e75cf",blue700:"#006dcc",gray900:"#1f2129",gray800:"#21232d"},a={main:{border:P(p.p500,.75),appBorder:P(p.s900,.75),background:P(p.background,1),primaryColor:P(p.p500,1),secondaryColor:P(p.s700,1),primaryTextColor:P(p.p50,1),secondaryTextColor:P(p.p500,1),secondaryBackground:P(p.secondaryBackground,1)},button:{headerBg:P(p.gray800,1),headerIconColor:P(p.p500,1),buttonBorderColor:P(p.p500,1),headerBorderHover:P(p.p500,.5),headerIconLightColor:P(p.p100,.5),primaryFilterBorderColor:P(p.p500,.25),secondaryFilterBorderColor:P(p.s700,.25)}},Ce={borderPrimary:P(p.p800,.5),textPrimary:P(p.p200,.8),textSecondary:P(p.p300,.5),background:"#161a2f",backgroundDim2:P("#18181b",.75),insetShadow:P(p.p500,.15)};P(p.p300,.05),P(p.p600,1),P(p.p500,.155),P(p.p500,.05),P(p.p500,.05),P(p.p500,.25),P(p.p500,1),P(p.p500,.25),`${P(p.p500,.25)}`,P(p.p500,.25),P(p.s500,.05),P(p.s600,1),P(p.s700,.275),P(p.s700,.05),P(p.s700,.05),P(p.s700,.25),P(p.s700,1),P(p.s700,.25),`${P(p.s700,.35)}`,P(p.s500,.25);P(p.gray900,.25),P(p.p500,.1),P(p.p600,1),P(p.p500,1),P(p.gray900,.25),P(p.s500,.1),P(p.s600,1),P(p.s500,1);`${P(p.p500,.25)}${P(p.gray900,.25)}`,P(p.p900,.75),P(p.p500,.5);const At=V.div.attrs({className:"tgg-invoice-barcode"})`
	position: relative;

	display: flex;
	justify-content: center;
	align-items: center;

	height: 48px;
	width: 100%;

	${({$status:t})=>(t===h.Paid||t===h.Cancelled||t===h.Rejected)&&`
		.tgg-barcode-wrapper {
			position: absolute;
			top: 10px;
		}
	`}

	${({$invoiceLocation:t})=>(t===O.Details||t===O.Accept)&&`
		height: 78px;

		.tgg-barcode-wrapper {
			top: 10px;
		}
	`}

	.tgg-barcode-wrapper {
		display: flex;
		align-items: center;
		margin-top: 5.5px;

		width: 90%;

		overflow: hidden;

		z-index: 1;

		svg {
			width: 100%;
			height: 100%;
		}

		${({$isPersonal:t})=>t?`
			text::selection {
				background: ${p.p400};
			}`:`
			text::selection {
				background:  ${p.s500};
			}
		`}

		&:hover {
			user-select: all;
			cursor: text;
		}
	}
`,_t=({uuid:t,status:i,isPersonal:r,invoiceLocation:c})=>{const s=v(N=>N.viewInvoiceModalOpen);f.useEffect(()=>{},[s]);const g=()=>i===h.Paid||i===h.Cancelled||i===h.Rejected?c===O.Details?[15,.75]:[25,1]:[15,.8],[j,y]=g(),d=N=>{const x=N.substring(0,3),_=N.substring(3,6),I=N.substring(6,9),u=N.substring(9,12),l=N.substring(12);return`${x} ${_} ${I} ${u} ${l}`};return e.jsx(At,{$status:i,$invoiceLocation:c,$isPersonal:r,children:e.jsx("div",{className:"tgg-barcode-wrapper",children:e.jsx(it,{value:d(t),background:"transparent",format:"CODE128",fontSize:i===h.Paid||i===h.Cancelled||i===h.Rejected?21:16,width:y,height:j})})})};async function G(t,i,r,c,s=1e4){const g={method:"post",headers:{"Content-Type":"application/json; charset=UTF-8"},body:JSON.stringify(i)};if(ve()&&c)return c;const j=window.GetParentResourceName?window.GetParentResourceName():"nui-frame-app";try{const y=fetch(`https://${r??j}/${t}`,g),d=new Promise((_,I)=>setTimeout(()=>I(new Error("Request timed out")),s)),N=await Promise.race([y,d]),x=await N.json();if(!N.ok)throw new Error(`HTTP error: ${N.status} - ${N.statusText}`);return x}catch(y){throw console.error("An error occurred:",y),y}}const Zt=V.div.attrs({className:"tgg-invoice-footer-container"})`
	position: relative;

	.tgg-additional-actions {
		display: flex;

		height: 42px;

		.tgg-button-placeholer {
			width: 50%;
		}

		.tgg-draft-btn,
		.tgg-cancel-btn {
			display: flex;
			justify-content: center;

			margin-top: 10px;

			color: rgba(255, 255, 255, 0.75);

			font-size: 0.75em;
			letter-spacing: 1px;
			text-transform: uppercase;

			width: 50%;

			background-color: transparent;
			outline: none;
			border: none;

			transition: color 0.25s ease-in-out;

			.tgg-label {
				padding: 0 2.5px;

				white-space: nowrap;
				overflow: hidden;
				text-overflow: ellipsis;

				&:after {
					width: 100%;
				}
			}

			&:hover:not(:disabled) {
				cursor: pointer;
				color: #fff;
			}

			&:disabled {
				cursor: not-allowed;

				.tgg-label {
					color: rgba(255, 255, 255, 0.5);
				}
			}
		}
	}

	${({$invoiceLocation:t})=>(t===O.Details||t===O.Accept)&&`
		.tgg-additional-actions {
			height: 66px;

			.tgg-cancel-btn,
			.tgg-draft-btn {
				font-size: 1em;
				margin-top: 17.5px;
			}
		}
	`}

	.tgg-status-wrapper {
		position: relative;

		display: flex;
		width: 100%;
		justify-content: center;

		.tgg-paid-stamp,
		.tgg-canceled-stamp {
			display: flex;
			justify-content: center;
			align-items: center;

			position: absolute;
			top: -27.5px;

			width: fit-content;
			height: fit-content;

			transform: rotate(-10deg);

			padding: 5px 20px;

			border: 5px solid #ffffff96;

			z-index: 1;

			filter: opacity(0.65);

			user-select: none;
			--webkit-user-drag: none;

			&.tgg-canceled-stamp {
				top: -30px;
				transform: rotate(-8.5deg);

				padding: 7.5px 15px;
			}

			.tgg-label {
				color: #ffffff96;
				font-size: 1em;
				font-weight: 800;
				letter-spacing: 1px;
				text-transform: uppercase;

				pointer-events: none;
			}
		}

		${({$invoiceLocation:t})=>t===O.Details&&`
				.tgg-paid-stamp,
				.tgg-canceled-stamp {
					padding: 7.5px 25px;

					.tgg-label {
						font-size: 1.5em;
					}
				}
		`}
	}
`,ze=({invoice:t,invoiceLocation:i})=>{const{t:r}=te(),[c,s]=f.useState(!1),g=v(L=>L.settingsConfig),j=v(L=>L.companyConfig),y=v(L=>L.appSettings),d=v(L=>L.playerData),N=v(L=>L.invoices),x=v(L=>L.jobInfo),_=v(L=>L.acceptInvoiceVisible),I=v(L=>L.viewInvoiceModalOpen),u=d==null?void 0:d.identifier,l=q(L=>L.setViewInvoice),$=q(L=>L.setCustomModal),w=q(L=>L.setPlayerData),k=q(L=>L.setInvoices),A=q(L=>L.setAcceptInvoiceVisible),n=q(L=>L.setViewInvoiceModalOpen),S=q(L=>L.setFlexOasisData),b=y.confirmPayment,Z=y.confirmCancel,U=()=>{$(null),pe()},T=()=>{$(null),ge()},X=()=>{b?$({visible:!0,type:Ze.ConfirmPayment,onOk:U,onCancel:()=>$(null),bodyText:r("invoice.confirmPayment")}):pe()},pe=()=>{var L,H;if(g.allowOverdraft&&((L=d==null?void 0:d.money)!=null&&L.bank)){const W=d.money.bank,ue=t.total,m=g.overdraftLimit;if(W-ue<-m){S({status:!0,message:"exceedingOverdraftLimit"});return}}else if((H=d==null?void 0:d.money)!=null&&H.bank&&d.money.bank<t.total){S({status:!0,message:"insufficientFunds"});return}s(!0),G("billing:invoice:pay",t.id,void 0,{success:!0,amountPaid:1e3}).then(W=>{var ue;if(W!=null&&W.success){const m=N.find(F=>F.id===t.id);m&&(m.status=h.Paid,k([...N])),s(!1),S({status:!0,message:"invoicePaid"}),W!=null&&W.amountPaid&&d&&w({...d,money:{...d.money,bank:((ue=d.money)==null?void 0:ue.bank)-W.amountPaid}}),I==J.Open&&(l(null),n(J.Closing))}else S({status:!0,message:"invoicePaymentFailed"})})},oe=()=>{l(t),n(J.Open)},he=()=>{Z?$({visible:!0,type:Ze.ConfirmCancel,onOk:T,onCancel:()=>$(null),bodyText:r("invoice.confirmCancel")}):ge()},ge=()=>{s(!0),G("billing:invoice:cancel",t.id,void 0,!0).then(L=>{if(L){const H=N.find(W=>W.id===t.id);if(!H)return;H.status=h.Cancelled,k([...N]),s(!1),S({status:!0,message:"invoiceCancelled"})}else S({status:!0,message:"invoiceCancelFailed"});I&&n(J.Closing)})},ae=()=>{var W;const L=j==null?void 0:j.cancel,H=(W=x==null?void 0:x.grade)==null?void 0:W.level;return!!(t.sender=="__personal"&&t.senderId===u||L&&L.length>0&&(L!=null&&L.includes("-1")||H&&(L!=null&&L.includes(H))))},ie=()=>{n(J.Closing),l(null)},me=()=>{G("billing:invoice:accept",t.id,void 0,!0).then(L=>{if(L)if(_)A(!1),G("billing:invoice:accepted");else{const H=N.find(W=>W.id===t.id);if(!H)return;H.status=h.Unpaid,k([...N]),s(!1),S({status:!0,message:"invoiceAccepted"})}else S({status:!0,message:"invoiceAcceptFailed"})})},fe=()=>{G("billing:invoice:reject",t.id,void 0,!0).then(L=>{if(L)if(_)A(!1),G("billing:invoice:rejected");else{const H=N.find(W=>W.id===t.id);if(!H)return;H.status=h.Rejected,k([...N]),s(!1),S({status:!0,message:"invoiceRejected"})}else S({status:!0,message:"invoiceRejectFailed"});I&&n(J.Closing)})};return e.jsxs(Zt,{$invoiceLocation:i,children:[e.jsx(_t,{isPersonal:t.sender==="__personal",uuid:t.uuid,status:t.status,invoiceLocation:i}),e.jsxs("div",{className:"tgg-status-wrapper",children:[t.status==h.Paid&&e.jsx("div",{className:"tgg-paid-stamp",children:e.jsx("div",{className:"tgg-label",children:r("invoice.paidStamp")})}),t.status==h.Cancelled&&e.jsx("div",{className:"tgg-canceled-stamp",children:e.jsx("div",{className:"tgg-label",children:r("invoice.cancelledStamp")})}),t.status==h.Rejected&&e.jsx("div",{className:"tgg-canceled-stamp",children:e.jsx("div",{className:"tgg-label",children:r("invoice.rejectedStamp")})})]}),e.jsxs("div",{className:"tgg-additional-actions",children:[i===O.Dashboard&&e.jsxs(e.Fragment,{children:[t.status===h.Unpaid&&t.recipientId===u&&e.jsxs(e.Fragment,{children:[e.jsx("button",{className:"tgg-cancel-btn",onClick:X,disabled:c,children:e.jsx("div",{className:"tgg-label",children:r("general.pay")})}),e.jsx("button",{className:"tgg-draft-btn",onClick:oe,children:e.jsx("div",{className:"tgg-label",children:r("general.view")})})]}),t.status===h.NotAccepted&&t.recipientId===u&&e.jsxs(e.Fragment,{children:[e.jsx("button",{className:"tgg-cancel-btn",onClick:me,disabled:c,children:e.jsx("div",{className:"tgg-label",children:r("general.accept")})}),e.jsx("button",{className:"tgg-draft-btn",onClick:fe,children:e.jsx("div",{className:"tgg-label",children:r("general.reject")})})]}),(t.status===h.Unpaid||t.status===h.NotAccepted)&&t.senderId===u&&e.jsxs(e.Fragment,{children:[ae()?e.jsx("button",{className:"tgg-cancel-btn",onClick:he,disabled:c,children:e.jsx("div",{className:"tgg-label",children:r("general.cancel")})}):e.jsx("div",{className:"tgg-button-placeholer"}),e.jsx("button",{className:"tgg-draft-btn",disabled:c,onClick:oe,children:e.jsx("div",{className:"tgg-label",children:r("general.view")})})]})]}),i===O.Accept&&e.jsx(e.Fragment,{children:t.status===h.NotAccepted&&t.recipientId===u&&e.jsxs(e.Fragment,{children:[e.jsx("button",{className:"tgg-cancel-btn",onClick:me,disabled:c,children:e.jsx("div",{className:"tgg-label",children:r("general.accept")})}),e.jsx("button",{className:"tgg-draft-btn",onClick:fe,children:e.jsx("div",{className:"tgg-label",children:r("general.reject")})})]})}),i===O.Details&&e.jsxs(e.Fragment,{children:[t.status===h.Unpaid&&t.recipientId===u&&e.jsxs(e.Fragment,{children:[e.jsx("button",{className:"tgg-cancel-btn",onClick:X,disabled:c,children:e.jsx("div",{className:"tgg-label",children:r("general.pay")})}),e.jsx("button",{className:"tgg-draft-btn",onClick:ie,children:e.jsx("div",{className:"tgg-label",children:r("general.close")})})]}),t.status===h.Unpaid&&t.senderId===u&&e.jsxs(e.Fragment,{children:[ae()?e.jsx("button",{className:"tgg-cancel-btn",onClick:he,disabled:c,children:e.jsx("div",{className:"tgg-label",children:r("general.cancel")})}):e.jsx("div",{className:"tgg-button-placeholer"}),e.jsx("button",{className:"tgg-cancel-btn",onClick:X,disabled:c,children:e.jsx("div",{className:"tgg-label",children:r("general.pay")})})]}),t.status===h.NotAccepted&&t.senderId===u&&e.jsxs(e.Fragment,{children:[ae()?e.jsx("button",{className:"tgg-cancel-btn",onClick:he,disabled:c,children:e.jsx("div",{className:"tgg-label",children:r("general.cancel")})}):e.jsx("div",{className:"tgg-button-placeholer"}),e.jsx("button",{className:"tgg-draft-btn",onClick:ie,children:e.jsx("div",{className:"tgg-label",children:r("general.close")})})]}),t.status===h.Unpaid&&t.senderId!==u&&t.recipientId!==u&&e.jsxs(e.Fragment,{children:[ae()?e.jsx("button",{className:"tgg-cancel-btn",onClick:X,disabled:c,children:e.jsx("div",{className:"tgg-label",children:r("general.pay")})}):e.jsx("div",{className:"tgg-button-placeholer"}),e.jsx("button",{className:"tgg-draft-btn",onClick:ie,children:e.jsx("div",{className:"tgg-label",children:r("general.close")})})]})]})]})]})},Qt=({bodyColor:t="#fff",footerTopColor:i="#fff",footerLeftColor:r="#fff",footerRightColor:c="#fff"})=>e.jsxs("svg",{className:"tgg-invoice-sheet",width:"200",height:"441",viewBox:"0 0 200 441",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:[e.jsx("path",{d:"M3.01886 0H0V345.229L11.1915 351.067C12.0569 351.518 12.4644 352.393 12.4139 353.243L23.4003 353.258C23.4001 353.261 23.4 353.265 23.3999 353.268C23.5126 349.995 26.1711 347.376 29.434 347.376C32.6993 347.376 35.3592 349.999 35.4682 353.275L46.7954 353.291C46.8963 350.007 49.5595 347.376 52.8302 347.376C56.1063 347.376 58.7729 350.016 58.8654 353.307L70.1908 353.323C70.2752 350.024 72.9451 347.376 76.2264 347.376C79.5132 347.376 82.1866 350.033 82.2625 353.34L93.5862 353.355C93.654 350.042 96.3307 347.376 99.6226 347.376C102.92 347.376 105.6 350.051 105.659 353.372L116.982 353.388C117.033 350.059 119.716 347.376 123.019 347.376C126.327 347.376 129.014 350.068 129.056 353.404L140.417 353.42C140.391 353.19 140.377 352.957 140.377 352.721C140.377 349.347 143.081 346.613 146.415 346.613C149.75 346.613 152.453 349.347 152.453 352.721C152.453 352.963 152.439 353.202 152.412 353.437L163.774 353.452C163.79 350.093 166.487 347.376 169.811 347.376C173.141 347.376 175.841 350.103 175.849 353.469L186.858 353.484C186.708 352.563 187.106 351.561 188.054 351.067L200 344.836V0H196.226C196.226 4.63815 192.51 8.39811 187.925 8.39811C183.34 8.39811 179.623 4.63815 179.623 0H166.792C166.792 4.63815 163.076 8.39811 158.491 8.39811C153.906 8.39811 150.189 4.63815 150.189 0H137.358C137.358 4.63815 133.642 8.39811 129.057 8.39811C124.472 8.39811 120.755 4.63815 120.755 0H107.925C107.925 4.63815 104.208 8.39811 99.6226 8.39811C95.0376 8.39811 91.3208 4.63815 91.3208 0H78.4906C78.4906 4.63815 74.7737 8.39811 70.1887 8.39811C65.6037 8.39811 61.8868 4.63815 61.8868 0H49.0566C49.0566 4.63815 45.3397 8.39811 40.7547 8.39811C36.1697 8.39811 32.4528 4.63815 32.4528 0H19.6227C19.6227 4.63815 15.9058 8.39811 11.3208 8.39811C6.73575 8.39811 3.01886 4.63815 3.01886 0ZM58.8659 353.324C58.8667 353.354 58.8672 353.385 58.8676 353.416C58.8678 353.439 58.8679 353.461 58.8679 353.484C58.8679 353.431 58.8672 353.377 58.8659 353.324Z",fill:t}),e.jsx("path",{d:"M99.6226 401H0V360.957L11.1915 355.119C11.9615 354.717 12.369 353.98 12.4139 353.224L23.4003 353.239C23.3976 353.314 23.3962 353.389 23.3962 353.465C23.3962 356.838 26.0994 359.573 29.434 359.573C32.7685 359.573 35.4717 356.838 35.4717 353.465C35.4717 353.395 35.4705 353.325 35.4682 353.256L46.7954 353.271C46.7934 353.336 46.7925 353.4 46.7925 353.465C46.7925 356.838 49.4956 359.573 52.8302 359.573C56.1647 359.573 58.8679 356.838 58.8679 353.465C58.8679 353.406 58.8671 353.347 58.8654 353.288L70.1908 353.304C70.1894 353.357 70.1887 353.411 70.1887 353.465C70.1887 356.838 72.8919 359.573 76.2264 359.573C79.561 359.573 82.2641 356.838 82.2641 353.465C82.2641 353.417 82.2636 353.369 82.2625 353.32L93.5862 353.336C93.5854 353.379 93.5849 353.422 93.5849 353.465C93.5849 356.838 96.2881 359.573 99.6226 359.573C102.957 359.573 105.66 356.838 105.66 353.465C105.66 353.428 105.66 353.39 105.659 353.353L116.982 353.368C116.981 353.401 116.981 353.433 116.981 353.465C116.981 356.838 119.684 359.573 123.019 359.573C126.353 359.573 129.057 356.838 129.057 353.465C129.057 353.438 129.056 353.412 129.056 353.385L140.417 353.401C140.759 356.445 143.314 358.809 146.415 358.809C149.51 358.809 152.061 356.453 152.412 353.417L163.774 353.433L163.774 353.465C163.774 356.838 166.477 359.573 169.811 359.573C173.146 359.573 175.849 356.838 175.849 353.465L175.849 353.45L186.858 353.465C186.967 354.134 187.366 354.76 188.054 355.119L200 361.35V401H99.6226Z",fill:i}),e.jsx("path",{d:"M196.123 441C196.123 436.327 192.425 432.539 187.862 432.539C183.3 432.539 179.602 436.327 179.602 441H166.835C166.835 436.327 163.137 432.539 158.575 432.539C154.013 432.539 150.314 436.327 150.314 441H137.548C137.548 436.327 133.85 432.539 129.287 432.539C124.725 432.539 121.027 436.327 121.027 441H108.261C108.261 436.327 104.562 432.539 100 432.539L100 401H200L200 441H196.123Z",fill:r}),e.jsx("path",{d:"M3.87705 441C3.87705 436.327 7.57543 432.539 12.1376 432.539C16.6998 432.539 20.3982 436.327 20.3982 441H33.1645C33.1645 436.327 36.8629 432.539 41.4251 432.539C45.9873 432.539 49.6856 436.327 49.6856 441H62.452C62.452 436.327 66.1504 432.539 70.7125 432.539C75.2747 432.539 78.9731 436.327 78.9731 441H91.7394C91.7394 436.327 95.4378 432.539 100 432.539L99.9997 401H-1.51828e-05L0.00021256 441H3.87705Z",fill:c})]}),He=({className:t,color:i="#CFCFCF"})=>e.jsx("svg",{className:`tgg-create-invoice-addon ${t??""}`,width:"407",height:"510",viewBox:"0 0 407 510",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:e.jsx("path",{d:"M400.591 65.8435L406.051 67.104L289.586 509.266L0.147241 442.742L116.677 0.296833L121.045 1.30525C119.502 7.99008 123.629 14.6508 130.263 16.1823C136.896 17.7139 143.525 13.5363 145.069 6.8515L163.632 11.1372C162.089 17.8221 166.216 24.4828 172.85 26.0143C179.483 27.5459 186.112 23.3683 187.656 16.6835L206.219 20.9692C204.676 27.6541 208.803 34.3148 215.437 35.8463C222.071 37.3779 228.699 33.2003 230.243 26.5155L248.806 30.8012C247.263 37.4861 251.39 44.1468 258.024 45.6783C264.658 47.2099 271.286 43.0323 272.83 36.3475L291.393 40.6332C289.85 47.3181 293.977 53.9788 300.611 55.5103C307.245 57.0419 313.874 52.8643 315.417 46.1795L333.98 50.4652C332.437 57.15 336.564 63.8107 343.198 65.3423C349.832 66.8739 356.461 62.6963 358.004 56.0115L376.567 60.2972C375.024 66.982 379.151 73.6427 385.785 75.1743C392.419 76.7058 399.048 72.5283 400.591 65.8435Z",fill:i})}),zt=()=>e.jsx("svg",{className:"tgg-invoice-purple",width:"254",height:"377",viewBox:"0 0 254 377",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:e.jsx("path",{opacity:"0.4",fillRule:"evenodd",clipRule:"evenodd",d:"M0.926592 46.475L3.21109 45.7765C4.27188 49.2462 7.94453 51.199 11.4142 50.1382C14.8839 49.0774 16.8367 45.4048 15.7759 41.9351L25.485 38.9667C26.5458 42.4364 30.2185 44.3892 33.6881 43.3284C37.1578 42.2676 39.1106 38.5949 38.0498 35.1253L47.759 32.1569C48.8197 35.6266 52.4924 37.5794 55.9621 36.5186C59.4317 35.4578 61.3845 31.7851 60.3237 28.3155L70.0329 25.3471C71.0937 28.8167 74.7663 30.7695 78.236 29.7087C81.7057 28.648 83.6585 24.9753 82.5977 21.5056L92.3068 18.5373C93.3676 22.0069 97.0403 23.9597 100.51 22.8989C103.98 21.8381 105.932 18.1655 104.872 14.6958L114.581 11.7274C115.642 15.1971 119.314 17.1499 122.784 16.0891C126.254 15.0283 128.206 11.3557 127.146 7.88599L136.855 4.9176C137.915 8.38727 141.588 10.3401 145.058 9.27927C148.527 8.21849 150.48 4.54583 149.419 1.07616L152.275 0.203109L231.142 258.165L223.527 265.59C222.484 266.607 223.025 268.376 224.458 268.636L234.923 270.533L253.026 329.743L250.17 330.616C249.109 327.146 245.436 325.194 241.967 326.254C238.497 327.315 236.544 330.988 237.605 334.457L227.896 337.426C226.835 333.956 223.163 332.003 219.693 333.064C216.223 334.125 214.27 337.798 215.331 341.267L205.622 344.236C204.561 340.766 200.889 338.813 197.419 339.874C193.949 340.935 191.996 344.607 193.057 348.077L183.348 351.046C182.287 347.576 178.615 345.623 175.145 346.684C171.675 347.745 169.723 351.417 170.783 354.887L161.074 357.855C160.013 354.386 156.341 352.433 152.871 353.494C149.401 354.554 147.449 358.227 148.509 361.697L138.8 364.665C137.739 361.195 134.067 359.243 130.597 360.303C127.127 361.364 125.175 365.037 126.235 368.507L116.526 371.475C115.466 368.005 111.793 366.053 108.323 367.113C104.854 368.174 102.901 371.847 103.962 375.316L101.677 376.015L83.4848 316.511L90.6188 309.555C91.6612 308.538 91.1203 306.769 89.6876 306.509L79.8834 304.731L0.926592 46.475ZM211.672 276.188C209.148 276.96 206.477 275.539 205.706 273.016C204.934 270.493 206.355 267.821 208.878 267.05C211.401 266.279 214.072 267.699 214.844 270.222C215.615 272.746 214.195 275.417 211.672 276.188ZM187.826 277.858C188.598 280.381 191.269 281.801 193.792 281.03C196.316 280.258 197.736 277.587 196.964 275.064C196.193 272.541 193.522 271.12 190.998 271.892C188.475 272.663 187.055 275.334 187.826 277.858ZM176.262 287.014C173.739 287.785 171.067 286.365 170.296 283.842C169.525 281.318 170.945 278.647 173.468 277.876C175.992 277.104 178.663 278.525 179.434 281.048C180.206 283.571 178.785 286.242 176.262 287.014ZM152.591 289.255C153.363 291.778 156.034 293.198 158.557 292.427C161.08 291.655 162.501 288.984 161.729 286.461C160.958 283.938 158.287 282.517 155.763 283.289C153.24 284.06 151.82 286.731 152.591 289.255ZM140.852 297.84C138.329 298.611 135.658 297.191 134.886 294.668C134.115 292.144 135.535 289.473 138.058 288.702C140.582 287.93 143.253 289.35 144.024 291.874C144.796 294.397 143.375 297.068 140.852 297.84ZM117.181 300.081C117.953 302.604 120.624 304.024 123.147 303.253C125.671 302.481 127.091 299.81 126.319 297.287C125.548 294.763 122.877 293.343 120.353 294.115C117.83 294.886 116.41 297.557 117.181 300.081ZM105.442 308.666C102.919 309.437 100.248 308.017 99.4763 305.494C98.7048 302.97 100.125 300.299 102.648 299.528C105.172 298.756 107.843 300.176 108.614 302.7C109.386 305.223 107.966 307.894 105.442 308.666Z",fill:"#673AB7"})}),Mt=()=>e.jsx("svg",{className:"tgg-invoice-blue",width:"253",height:"377",viewBox:"0 0 253 377",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:e.jsx("path",{opacity:"0.4",fillRule:"evenodd",clipRule:"evenodd",d:"M0.00277944 46.475L2.28728 45.7765C3.34807 49.2462 7.02072 51.199 10.4904 50.1382C13.9601 49.0774 15.9128 45.4048 14.8521 41.9351L24.5612 38.9667C25.622 42.4364 29.2947 44.3892 32.7643 43.3284C36.234 42.2676 38.1868 38.5949 37.126 35.1253L46.8351 32.1569C47.8959 35.6266 51.5686 37.5794 55.0383 36.5186C58.5079 35.4578 60.4607 31.7851 59.3999 28.3155L69.1091 25.3471C70.1699 28.8167 73.8425 30.7695 77.3122 29.7087C80.7819 28.648 82.7346 24.9753 81.6739 21.5056L91.383 18.5373C92.4438 22.0069 96.1164 23.9597 99.5861 22.8989C103.056 21.8381 105.009 18.1655 103.948 14.6958L113.657 11.7274C114.718 15.1971 118.39 17.1499 121.86 16.0891C125.33 15.0283 127.283 11.3557 126.222 7.88599L135.931 4.9176C136.992 8.38727 140.664 10.3401 144.134 9.27927C147.604 8.21849 149.556 4.54583 148.496 1.07616L151.351 0.203109L230.218 258.165L222.603 265.59C221.561 266.607 222.102 268.376 223.534 268.636L234 270.533L252.102 329.743L249.246 330.616C248.185 327.146 244.513 325.194 241.043 326.254C237.573 327.315 235.621 330.988 236.681 334.457L226.972 337.426C225.911 333.956 222.239 332.003 218.769 333.064C215.299 334.125 213.347 337.798 214.407 341.267L204.698 344.236C203.637 340.766 199.965 338.813 196.495 339.874C193.025 340.935 191.073 344.607 192.133 348.077L182.424 351.046C181.364 347.576 177.691 345.623 174.221 346.684C170.752 347.745 168.799 351.417 169.86 354.887L160.15 357.855C159.09 354.386 155.417 352.433 151.947 353.494C148.478 354.554 146.525 358.227 147.586 361.697L137.876 364.665C136.816 361.195 133.143 359.243 129.673 360.303C126.204 361.364 124.251 365.037 125.312 368.507L115.603 371.475C114.542 368.005 110.869 366.053 107.399 367.113C103.93 368.174 101.977 371.847 103.038 375.316L100.753 376.015L82.561 316.511L89.695 309.555C90.7374 308.538 90.1965 306.769 88.7638 306.509L78.9596 304.731L0.00277944 46.475ZM210.748 276.188C208.225 276.96 205.554 275.539 204.782 273.016C204.011 270.493 205.431 267.821 207.954 267.05C210.478 266.279 213.149 267.699 213.92 270.222C214.692 272.746 213.271 275.417 210.748 276.188ZM186.902 277.858C187.674 280.381 190.345 281.801 192.868 281.03C195.392 280.258 196.812 277.587 196.041 275.064C195.269 272.541 192.598 271.12 190.075 271.892C187.551 272.663 186.131 275.334 186.902 277.858ZM175.338 287.014C172.815 287.785 170.144 286.365 169.372 283.842C168.601 281.318 170.021 278.647 172.544 277.876C175.068 277.104 177.739 278.525 178.51 281.048C179.282 283.571 177.861 286.242 175.338 287.014ZM151.667 289.255C152.439 291.778 155.11 293.198 157.633 292.427C160.157 291.655 161.577 288.984 160.805 286.461C160.034 283.938 157.363 282.517 154.839 283.289C152.316 284.06 150.896 286.731 151.667 289.255ZM139.928 297.84C137.405 298.611 134.734 297.191 133.962 294.668C133.191 292.144 134.611 289.473 137.134 288.702C139.658 287.93 142.329 289.35 143.1 291.874C143.872 294.397 142.452 297.068 139.928 297.84ZM116.257 300.081C117.029 302.604 119.7 304.024 122.223 303.253C124.747 302.481 126.167 299.81 125.395 297.287C124.624 294.763 121.953 293.343 119.43 294.115C116.906 294.886 115.486 297.557 116.257 300.081ZM104.518 308.666C101.995 309.437 99.324 308.017 98.5525 305.494C97.781 302.97 99.2012 300.299 101.725 299.528C104.248 298.756 106.919 300.176 107.691 302.7C108.462 305.223 107.042 307.894 104.518 308.666Z",fill:"#1E88E5"})}),Ot=V.div.attrs({className:"tgg-invoice"})`
	position: relative;

	display: flex;
	justify-content: end;
	align-items: start;

	width: 250px;
	height: 440px;

	z-index: 3;

	/* If the invoice is on the dashboard and it is paid or cancelled */
	${({$status:t,$type:i})=>i===O.Dashboard&&(t===h.Paid||t===h.Cancelled||t===h.Rejected)&&"filter: opacity(0.5);"}

	.tgg-sheet-wrapper {
		position: relative;

		width: 200px;
		height: 440px;

		z-index: 2;

		-webkit-font-smoothing: antialiased;
		backface-visibility: hidden;

		.tgg-invoice-sheet {
			z-index: 2;
		}

		.tgg-invoice-details-wrapper {
			position: absolute;

			top: 0;
			height: 100%;
			width: 100%;
		}
	}

	.tgg-invoice-addon {
		position: absolute;

		left: -17.5px;

		top: 5px;

		width: 200px;
		height: 265px;

		z-index: 1;

		overflow: hidden;

		.tgg-invoice-blue,
		.tgg-invoice-purple {
		}

		.tgg-invoice-new {
			position: absolute;

			top: 45px;
			left: 10px;

			display: flex;
			justify-content: center;
			align-items: center;

			color: #0f1327;

			font-size: 23px;
			font-weight: 600;

			opacity: 0.8;

			border-radius: 5px;

			transform: rotate(340deg);
		}
	}

	.tgg-create-invoice-addon {
		position: absolute;

		right: -57.5px;

		top: 5px;

		width: 407px;
		height: 510px;

		z-index: 1;

		&.tgg-2nd {
			top: 35px;

			transform: rotate(10deg);

			right: -82.5px;

			z-index: 0;
		}
	}

	.tgg-invoice-body {
		position: relative;

		height: 353px;

		/* background-color: #ff000055; */

		z-index: 3;
	}

	.tgg-invoice-footer {
		position: relative;

		height: 88px;
		width: 100%;

		z-index: 3;

		/* background-color: #22ff0054; */
	}

	/* If the invoice is displayed in the View Invoice Details modal */
	${({$type:t})=>(t===O.Details||t===O.Create||t===O.Accept)&&`
			width: 330px;
			height: 725px;

			.tgg-sheet-wrapper {
				width: inherit;
				height: inherit;

				.tgg-invoice-sheet {
					height: 100%;
					width: 100%;
				}
			}

			.tgg-invoice-body { 
				height: 580.5px;
			}

			.tgg-invoice-footer { 
				height: 145px;
			}
		`}
`,Se=({type:t,body:i,footer:r,invoice:c})=>{const{t:s}=te(),[g,j]=f.useState([]),y=v(l=>l.settingsConfig),d=v(l=>l.viewInvoice),N=v(l=>l.menuType),x=v(l=>l.createInvoiceModalOpen),_=v(l=>l.acceptInvoiceVisible);f.useEffect(()=>{c&&I(c)},[c==null?void 0:c.status,c==null?void 0:c.sender]),f.useEffect(()=>{!c&&d&&(c=d),c&&I(c)},[d]),f.useEffect(()=>{if(t===O.Create){let l=[];N===D.Business?l=[p.s500,p.s700,p.s900]:N===D.Personal&&(l=[p.p500,p.p700,p.p900]),j(l)}},[x,N]),f.useEffect(()=>{if(t===O.Accept){let l=[];(c==null?void 0:c.sender)==="__personal"?l=[p.p500,p.p700,p.p900]:l=[p.s500,p.s700,p.s900],j(l)}},[_]);const I=l=>{let $=[];((l==null?void 0:l.status)===h.Cancelled||(l==null?void 0:l.status)===h.Paid||(l==null?void 0:l.status)===h.Rejected)&&(l==null?void 0:l.sender)==="__personal"?$=[p.p600,p.p600,p.p600]:((l==null?void 0:l.status)===h.Unpaid||(l==null?void 0:l.status)===h.NotAccepted)&&(l==null?void 0:l.sender)==="__personal"?$=[p.p500,p.p900,p.p700]:((l==null?void 0:l.status)===h.Cancelled||(l==null?void 0:l.status)===h.Paid||(l==null?void 0:l.status)===h.Rejected)&&(l==null?void 0:l.sender)!=="__personal"?$=[p.s700,p.s700,p.s700]:((l==null?void 0:l.status)===h.Unpaid||(l==null?void 0:l.status)===h.NotAccepted)&&(l==null?void 0:l.sender)!=="__personal"&&($=[p.s700,p.s950,p.s900]),j($)},u=()=>{if(!c)return!1;const l=y.highlightNewInvoiceDuration,$=new Date().getTime(),w=new Date(c.timestamp).getTime();return($-w)/6e4<=l};return e.jsxs(Ot,{$status:c==null?void 0:c.status,$type:t,children:[e.jsxs("div",{className:"tgg-sheet-wrapper",children:[e.jsx(Qt,{footerTopColor:g[0],footerRightColor:g[1],footerLeftColor:g[2]}),e.jsxs("div",{className:"tgg-invoice-details-wrapper",children:[e.jsx("div",{className:"tgg-invoice-body",children:i}),e.jsx("div",{className:"tgg-invoice-footer",children:r})]})]}),t===O.Dashboard&&c&&e.jsxs("div",{className:"tgg-invoice-addon",children:[c.sender==="__personal"?e.jsx(Mt,{}):e.jsx(zt,{}),u()&&e.jsx("div",{className:"tgg-invoice-new",children:s("invoice.new")})]}),t===O.Create&&e.jsxs("div",{className:"tgg-create-invoice-addon",children:[e.jsx(He,{}),e.jsx(He,{className:"tgg-2nd",color:"#6B6B6B"})]})]})},Ft=V.div.attrs({className:"tgg-accept-invoice"})`
	position: relative;

	width: 100%;
	height: 100%;

	display: flex;
	justify-content: end;
	align-items: center;

	padding: 0 5em;

	overflow: hidden;

	z-index: 999999;

	.tgg-invoice-popup {
		position: absolute;
		bottom: -100%;
		transition: bottom 0.5s ease-in-out;
	}

	.tgg-visible {
		bottom: 40px;
	}
`,Tt=({invoice:t})=>{const i=v(r=>r.acceptInvoiceVisible);return t?e.jsx(Ft,{children:e.jsx("div",{className:`tgg-invoice-popup${i?" tgg-visible":""}`,children:e.jsx(Se,{invoice:t,body:e.jsx(Qe,{invoice:t,invoiceLocation:O.Accept}),footer:e.jsx(ze,{invoice:t,invoiceLocation:O.Accept}),type:O.Accept})})}):e.jsx(e.Fragment,{})},xe=(t,i)=>{const r=f.useRef(Lt);f.useEffect(()=>{r.current=i},[i]),f.useEffect(()=>{const c=s=>{const{action:g,data:j}=s.data;r.current&&g===t&&r.current(j)};return window.addEventListener("message",c),()=>window.removeEventListener("message",c)},[t])},Xe=(t,i=0)=>{for(const r of t)(ve()||r.internal)&&setTimeout(()=>{!r.internal&&console.info(`[DEBUG] Dispatching event: ${r.action}`),window.dispatchEvent(new MessageEvent("message",{data:{action:r.action,data:r.data}}))},i)},Wt=()=>e.jsxs("svg",{width:"64",height:"64",viewBox:"0 0 512 512",children:[e.jsx("path",{fill:"#1e88e5",d:"M121 135c0 74.443 60.557 135 135 135s135-60.557 135-135S330.443 0 256 0 121 60.557 121 135z","data-original":"#45c1f1"}),e.jsx("path",{fill:"#0c65bd",d:"M391 135C391 60.557 330.443 0 256 0v270c74.443 0 135-60.557 135-135z","data-original":"#44a4ec"}),e.jsx("path",{fill:"#1e88e5",d:"M31 497c0 8.291 6.709 15 15 15h420c8.291 0 15-6.709 15-15 0-107.52-87.48-197-195-197h-60c-107.52 0-195 89.48-195 197z","data-original":"#45c1f1"}),e.jsx("path",{fill:"#0c65bd",d:"M286 300h-30v212h210c8.291 0 15-6.709 15-15 0-107.52-87.48-197-195-197z","data-original":"#44a4ec"})]}),Ve=()=>e.jsx("svg",{width:"41",height:"38",viewBox:"0 0 41 38",fill:"currentColor",children:e.jsx("path",{d:"M34.551 41.2117L40.7154 12.2104C41.1448 10.19 40.5332 6.9189 37.0866 6.18631L10.2784 0.488051C9.80376 0.349419 8.03125 -0.0426909 6.03523 1.0863C3.65737 2.4316 1.97605 5.35154 1.03738 9.76765L0.747382 11.132L6.20218 12.2914L0.431844 39.4387C0.0873389 41.0595 0.260907 42.3918 0.948594 43.3971C1.49228 44.1921 2.19391 44.5389 2.61533 44.6841L2.61064 44.7062L31.1981 50.7826C36.5917 51.9291 39.1964 46.6817 39.8202 43.7468L40.1109 42.3794L34.551 41.2117ZM4.09197 8.99162C4.98919 5.7246 6.228 4.27857 7.20181 3.63984C7.52324 4.02674 7.77236 4.9043 7.41484 6.58628L6.78204 9.56341L4.09197 8.99162ZM6.77245 36.8009C5.8598 41.0946 4.31789 42.1097 3.49429 42.0357C3.16261 41.8987 2.88659 41.2981 3.15876 40.0177L10.1416 7.16588C10.4909 5.52246 10.4082 4.25356 10.0997 3.29109L36.5069 8.91371C38.3027 9.29542 38.0932 11.0965 37.9874 11.6306L31.8214 40.6392L7.06154 35.4409L6.77245 36.8009ZM31.778 48.0546L7.24732 42.8405C7.96361 41.9295 8.64069 40.6161 9.16928 38.7312L36.6793 44.5077C36.0451 46.1551 34.5978 48.654 31.778 48.0546ZM25.7918 12.7551L34.3095 14.5656L33.7297 17.293L25.2121 15.4825L25.7918 12.7551ZM24.5036 18.8159L33.0212 20.6264L32.4416 23.3532L23.924 21.5427L24.5036 18.8159ZM23.2455 24.7346L31.7631 26.5451L31.1835 29.2719L22.6659 27.4614L23.2455 24.7346ZM10.2996 28.4806L30.5586 32.7868L29.9789 35.5142L9.71988 31.208L10.2996 28.4806ZM20.4945 19.9379C20.4208 20.285 20.294 20.6227 20.1177 20.9403C19.9367 21.2683 19.6864 21.558 19.375 21.8009C19.0674 22.0413 18.6912 22.2281 18.2582 22.3542C17.8982 22.4587 17.4829 22.5105 17.0216 22.5078L16.598 24.5007L13.9807 23.9444L14.3891 22.0231C13.7308 21.8096 13.1902 21.5718 12.7796 21.3157C12.319 21.0297 11.988 20.8052 11.7684 20.6286L11.5491 20.4534L12.9576 18.2419L13.2294 18.4532C13.5471 18.7011 13.944 18.9525 14.4084 19.1996C14.8628 19.4427 15.3679 19.6242 15.9096 19.7394C16.6667 19.9003 16.981 19.8334 17.1006 19.7795C17.2844 19.697 17.3918 19.5561 17.4386 19.3357C17.4686 19.195 17.4628 19.0747 17.4207 18.9686C17.3725 18.8464 17.2845 18.7215 17.1598 18.5977C17.0189 18.4571 16.8286 18.3053 16.5935 18.1472C16.3451 17.9793 16.0561 17.795 15.7272 17.594C15.3957 17.3866 15.0733 17.1671 14.7663 16.9381C14.446 16.6992 14.1619 16.4258 13.9219 16.1253C13.672 15.8111 13.4921 15.4505 13.3862 15.0518C13.2777 14.6475 13.277 14.1874 13.3839 13.6842C13.4646 13.3047 13.5992 12.9451 13.7833 12.6176C13.9716 12.2828 14.2176 11.989 14.5151 11.7451C14.8148 11.4999 15.1784 11.3123 15.5951 11.1878C15.9333 11.0864 16.3135 11.0315 16.7276 11.0242L17.105 9.24862L19.7223 9.80493L19.364 11.4906C19.8031 11.6396 20.1891 11.7984 20.5149 11.963C20.9017 12.1597 21.2127 12.3429 21.4382 12.5098L21.6501 12.6655L20.4712 15.0308L20.1739 14.8223C19.8719 14.6117 19.5052 14.4045 19.0849 14.209C18.6686 14.0156 18.2124 13.8655 17.7295 13.7628C17.1835 13.6468 16.9097 13.698 16.7762 13.7604C16.604 13.8422 16.5102 13.9585 16.4716 14.1397C16.4472 14.2548 16.4479 14.3566 16.4743 14.4403C16.5018 14.5274 16.562 14.6176 16.6536 14.7074C16.7676 14.8212 16.9179 14.9414 17.1004 15.0672C17.2944 15.2019 17.5312 15.352 17.8096 15.5199C18.2539 15.798 18.6603 16.0865 19.0231 16.3779C19.3976 16.6808 19.7146 17.0073 19.9656 17.3491C20.2262 17.7033 20.4085 18.0977 20.5082 18.5226C20.6067 18.9529 20.6029 19.4281 20.4945 19.9379Z",fill:"currentColor"})}),Ht=()=>e.jsx("svg",{width:"25",height:"23",viewBox:"0 0 25 23",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:e.jsx("path",{d:"M24 3.55556H21.4444M24 11.2222H17.6111M24 18.8889H17.6111M6.11111 21.4444V13.2171C6.11111 12.9513 6.11111 12.8184 6.08502 12.6913C6.06188 12.5786 6.0236 12.4695 5.97122 12.3669C5.91217 12.2513 5.82916 12.1476 5.66311 11.9399L1.448 6.67111C1.28195 6.46356 1.19894 6.35978 1.13989 6.24422C1.08751 6.14169 1.04923 6.03255 1.02609 5.91978C1 5.79266 1 5.65976 1 5.39396V3.04444C1 2.32882 1 1.97101 1.13926 1.69768C1.26178 1.45725 1.45725 1.26178 1.69768 1.13927C1.97101 1 2.32882 1 3.04444 1H14.2889C15.0046 1 15.3624 1 15.6357 1.13927C15.8761 1.26178 16.0715 1.45725 16.1941 1.69768C16.3333 1.97101 16.3333 2.32882 16.3333 3.04444V5.39396C16.3333 5.65976 16.3333 5.79266 16.3073 5.91978C16.2841 6.03255 16.2458 6.14169 16.1934 6.24422C16.1344 6.35978 16.0513 6.46356 15.8853 6.67111L11.6702 11.9399C11.5042 12.1476 11.4212 12.2513 11.3621 12.3669C11.3098 12.4695 11.2714 12.5786 11.2483 12.6913C11.2222 12.8184 11.2222 12.9513 11.2222 13.2171V17.6111L6.11111 21.4444Z",stroke:"#1E88E5",strokeWidth:"2",strokeLinecap:"round",strokeLinejoin:"round"})}),Vt=()=>e.jsx("svg",{width:"17",height:"17",viewBox:"0 0 17 17",fill:"none",xmlns:"http://www.w3.org/2000/svg",children:e.jsx("path",{d:"M16.7688 14.7001L13.4582 11.3895C13.3088 11.2401 13.1062 11.1571 12.8937 11.1571H12.3525C13.2689 9.98491 13.8135 8.51058 13.8135 6.90676C13.8135 3.09144 10.7221 0 6.90676 0C3.09144 0 0 3.09144 0 6.90676C0 10.7221 3.09144 13.8135 6.90676 13.8135C8.51058 13.8135 9.98491 13.2689 11.1571 12.3525V12.8937C11.1571 13.1062 11.2401 13.3088 11.3895 13.4582L14.7001 16.7688C15.0122 17.0809 15.517 17.0809 15.8258 16.7688L16.7655 15.8291C17.0776 15.517 17.0776 15.0122 16.7688 14.7001ZM6.90676 11.1571C4.55912 11.1571 2.65644 9.25771 2.65644 6.90676C2.65644 4.55912 4.5558 2.65644 6.90676 2.65644C9.25439 2.65644 11.1571 4.5558 11.1571 6.90676C11.1571 9.25439 9.25771 11.1571 6.90676 11.1571Z",fill:"currentColor"})}),Et=()=>e.jsx("svg",{width:"75",height:"75",viewBox:"0 0 512.018 512.018",children:e.jsx("g",{children:e.jsx("path",{d:"M6.98 256.673c-5.504 2.027-8.341 8.128-6.336 13.653l6.699 18.432L58.35 237.75 6.98 256.673zM55.257 420.513l30.72 84.48a10.57 10.57 0 0 0 5.525 6.016 10.73 10.73 0 0 0 4.501 1.003c1.259 0 2.496-.213 3.691-.661l33.899-12.501-78.336-78.337zM511.364 348.385l-35.157-96.661-84.373 84.373 41.813-15.403c5.483-2.091 11.669.768 13.696 6.315 2.048 5.525-.789 11.669-6.315 13.696l-53.12 19.584a10.617 10.617 0 0 1-3.691.661c-4.331 0-8.427-2.667-10.005-6.976-.021-.064 0-.128-.021-.192l-89.408 89.408 220.245-81.152c5.525-2.026 8.362-8.128 6.336-13.653zM508.889 173.793 338.222 3.126c-4.16-4.16-10.923-4.16-15.083 0l-320 320c-4.16 4.16-4.16 10.923 0 15.083l170.667 170.667a10.56 10.56 0 0 0 7.531 3.136c2.731 0 5.461-1.045 7.552-3.115l320-320a10.7 10.7 0 0 0 0-15.104zm-384 121.771L82.222 338.23a10.716 10.716 0 0 1-15.104 0c-4.16-4.16-4.16-10.923 0-15.083l42.667-42.667c4.16-4.16 10.923-4.16 15.083 0 4.16 4.161 4.181 10.902.021 15.084zm184.213 13.546c-7.552 7.552-17.813 11.179-29.227 11.179-18.859 0-40.896-9.877-59.328-28.331-13.483-13.483-22.955-29.611-26.645-45.397-4.096-17.6-.725-32.917 9.493-43.157 10.219-10.24 25.536-13.611 43.157-9.493 15.787 3.691 31.915 13.141 45.397 26.645 29.633 29.61 37.185 68.522 17.153 88.554zm135.787-120.213-42.667 42.667a10.716 10.716 0 0 1-15.104 0c-4.16-4.16-4.16-10.923 0-15.083l42.667-42.667c4.16-4.16 10.923-4.16 15.083 0s4.181 10.902.021 15.083z",fill:"currentColor",opacity:"1"})})}),Rt=()=>e.jsx("svg",{width:"512",height:"512",viewBox:"0 0 512 512",children:e.jsx("g",{children:e.jsxs("g",{"data-name":"Layer 2",children:[e.jsx("circle",{cx:"256",cy:"256",r:"256",fill:"#00a1f5"}),e.jsx("path",{fill:"#ffffff",d:"M375.54 143.39a25.88 25.88 0 0 0-10.3-21.18c-12.38-8.34-24.22-22.32-38.57-22.34-13.82-.12-24.27 12.75-35.32 19.78-11-7-21.53-19.88-35.33-19.75-7-.23-14.19 3.52-20 8.3-5 3.58-10.21 7.91-15.35 11.43-5.09-3.45-10.22-7.78-15.19-11.31-5.72-4.76-12.82-8.67-20.15-8.43-10.55-.43-19 7.73-27 13.62-11.22 8-22.44 15.4-21.87 31v222.68c0 9.81 3.86 17.65 11.51 23.29 4.77 3.52 9.59 7.16 14.25 10.68 6.64 5.39 14.56 11 23.11 10.69 13.91.14 24.26-12.72 35.37-19.76 11.14 7.07 21.36 19.84 35.35 19.75 7 .2 14-3.38 19.53-8 5.57-3.87 11.11-8.82 16.88-12.45 36.5 20.87 33.3 20 69.25-.66 9-5.2 13.83-13.47 13.83-23.89.03-72.35.03-147.53 0-223.45zm-172.17 46c31.11-.06 61 0 91.87 0 11.46-.05 26.57-2.06 27.29 13.53.11 7.86-6.57 13.69-14.38 13.56h-81.42c-12.64-1.11-35.86 5.31-37.22-12.89a13.58 13.58 0 0 1 13.86-14.23zm105 133H203.9a14.85 14.85 0 0 1-10.64-4.14c-8.38-8.45-1.88-23.54 10.62-22.93h104.26c7.7 0 13.6 5 14.35 12.14 1.01 7.95-6.05 15.36-14.09 14.92zm0-53c-28.74-.06-76 0-104.77 0-18.16.07-18.9-26.1-.85-27 8.06-.16 48.33.06 57.2 0h48.41c5.79 0 10.16 2.58 12.65 7.45 4.93 8.77-2.42 20.09-12.61 19.57z"})]})})}),Yt=()=>e.jsxs("svg",{xmlns:"http://www.w3.org/2000/svg",width:"512",height:"512",enableBackground:"new 0 0 512 512",viewBox:"0 0 682.667 682.667",children:[e.jsx("defs",{children:e.jsx("clipPath",{id:"a",clipPathUnits:"userSpaceOnUse",children:e.jsx("path",{d:"M0 512h512V0H0z","data-original":"currentColor"})})}),e.jsxs("g",{fill:"none",stroke:"currentColor",strokeLinecap:"round",strokeLinejoin:"round",strokeMiterlimit:"10",strokeWidth:"15",clipPath:"url(#a)",transform:"matrix(1.33333 0 0 -1.33333 0 682.667)",children:[e.jsx("path",{d:"M167.348 274.711h-52.07a12.717 12.717 0 01-12.08-8.741L63.977 146.834M448.023 146.834L408.801 265.97a12.717 12.717 0 01-12.08 8.741h-51.548M496.353 83.707v59.15c0 1.351-.215 2.694-.638 3.977l-34.349 104.337","data-original":"currentColor"}),e.jsx("path",{d:"M206.73 351.223H92.775a12.718 12.718 0 01-12.08-8.741l-64.41-195.648a12.697 12.697 0 01-.638-3.976v-39.151M449.791 286.33l-18.486 56.153a12.72 12.72 0 01-12.08 8.741H306.757","data-original":"currentColor"}),e.jsx("path",{d:"M15.648 52.407V20.218c0-7.024 5.694-12.718 12.718-12.718h455.269c7.024 0 12.718 5.694 12.718 12.718v110.364c0 7.024-5.694 12.718-12.718 12.718h-93.901c-4.86 0-9.295-2.77-11.428-7.137l-18.452-37.78a12.714 12.714 0 00-11.427-7.137H163.574c-4.86 0-9.294 2.769-11.427 7.137l-18.452 37.78a12.719 12.719 0 01-11.428 7.137H28.366c-7.024 0-12.718-5.694-12.718-12.718V89.433M53.912 42.107h27.446M53.912 65.536h27.446M408.802 265.97v85.252M103.198 265.97v85.252M273.298 253.356c-4.614 3.938-11.087 6.409-18.278 6.431-7.191.021-13.679-2.411-18.316-6.322M297.351 287.937h.09M214.559 287.937h.089M297.342 287.937h.089","data-original":"currentColor"}),e.jsx("path",{d:"M274.05 194.118c39.399 8.311 68.974 43.271 68.974 85.144 0 48.062-38.961 87.024-87.023 87.024s-87.024-38.962-87.024-87.024c0-41.543 29.112-76.282 68.047-84.942M216.33 504.5l-22.732-22.732M216.33 481.768L193.598 504.5M108.113 432.485c0 14.771 11.974 26.745 26.745 26.745s26.745-11.974 26.745-26.745-11.974-26.746-26.745-26.746-26.745 11.975-26.745 26.746M385.96 430.903l-22.732-22.732M385.96 408.17l-22.732 22.732M255.61 411.502l.066 22.333M222.304 401.983L210.7 421.357M300.579 420.987l-11.72-19.31M345.704 473.753c0-11.733-9.511-21.244-21.244-21.244s-21.244 9.511-21.244 21.244 9.511 21.244 21.244 21.244 21.244-9.511 21.244-21.244z","data-original":"currentColor"})]})]}),Ut=()=>e.jsx("svg",{width:"48",height:"48",viewBox:"0 0 32 32",children:e.jsxs("g",{children:[e.jsx("path",{d:"M27.01 2.5H4.99A2.493 2.493 0 0 0 2.5 4.99V29a.5.5 0 0 0 .78.414l2.47-1.669 2.466 1.669a.503.503 0 0 0 .561 0l2.469-1.669 2.473 1.67c.169.114.39.114.56 0l2.469-1.669 2.475 1.67a.5.5 0 0 0 .559 0l2.48-1.67 2.48 1.67a.498.498 0 0 0 .779-.414V13.243l.721-.485 2.48 1.67a.5.5 0 0 0 .779-.414V4.99A2.494 2.494 0 0 0 27.01 2.5zm-2.49 2.49v23.07l-1.98-1.333a.5.5 0 0 0-.559 0l-2.48 1.67-2.476-1.67a.501.501 0 0 0-.56 0l-2.468 1.669-2.473-1.67a.501.501 0 0 0-.56 0l-2.469 1.669-2.465-1.668a.501.501 0 0 0-.56 0L3.5 28.059V4.99c0-.822.668-1.49 1.49-1.49h20.026a2.481 2.481 0 0 0-.496 1.49zm3.98 8.084-1.98-1.333a.5.5 0 0 0-.559 0l-.441.297V4.99a1.491 1.491 0 0 1 2.98 0z",fill:"#ffffff"}),e.jsx("path",{d:"M6.553 8.901h14.914a.5.5 0 0 0 0-1H6.553a.5.5 0 0 0 0 1zM6.553 13.265h14.914a.5.5 0 0 0 0-1H6.553a.5.5 0 0 0 0 1zM6.553 17.628h14.914a.5.5 0 0 0 0-1H6.553a.5.5 0 0 0 0 1zM6.553 21.991h14.914a.5.5 0 0 0 0-1H6.553a.5.5 0 0 0 0 1z",fill:"#ffffff"})]})}),Dt=()=>e.jsx("svg",{width:"48",height:"48",viewBox:"0 0 512 512",children:e.jsx("g",{children:e.jsx("path",{d:"M464.299 214.018c22.908 0 41.548-18.635 41.548-41.549v-43.822a8.06 8.06 0 0 0-8.061-8.061h-58.91V56.752c0-22.908-18.639-41.547-41.547-41.547H80.199c-22.367 0-40.557 18.191-40.557 40.561V437.12c-.034 13.992-11.439 25.404-25.429 25.449h-.022c-4.448.014-8.044 3.623-8.038 8.064a8.058 8.058 0 0 0 8.061 8.055h45.523a8.02 8.02 0 0 0 3.833-.973l22.411-12.119 11.498 10.883a8.067 8.067 0 0 0 5.547 2.209 8.033 8.033 0 0 0 3.898-1.008l24.436-13.535 24.43 13.535a8.041 8.041 0 0 0 6.915.42l29.323-11.818 18.59 11.24a8.057 8.057 0 0 0 7.846.277l22.452-11.521 24.748 11.645a8.108 8.108 0 0 0 3.43.766h49.938c.045 0 .086-.012.133-.012 18.659 11.48 40.601 18.119 64.067 18.119 67.612 0 122.614-55.006 122.614-122.617 0-67.609-55.002-122.613-122.614-122.613-3.821 0-7.597.199-11.329.545v-38.092h92.396zm25.429-77.313v35.764c0 14.025-11.407 25.432-25.429 25.432h-.896c-.07-.004-.131-.027-.197-.029-13.609-.611-24.299-11.779-24.33-25.402v-35.764h50.852zm-66.967-79.953v115.742a41.497 41.497 0 0 0 8.723 25.406h-59.58V56.773c.029-13.25 9.989-24.146 23.157-25.342.189-.02.367-.078.554-.107h1.715c14.02 0 25.431 11.41 25.431 25.428zm66.967 317.426c0 58.725-47.771 106.498-106.495 106.498-58.721 0-106.499-47.773-106.499-106.498 0-58.721 47.778-106.496 106.499-106.496 58.723 0 106.495 47.775 106.495 106.496zm-229.11 0c0 34.707 14.514 66.063 37.768 88.391h-27.491l-26.704-12.561a8.03 8.03 0 0 0-7.104.123l-21.977 11.275-18.193-10.998a8.004 8.004 0 0 0-7.179-.578l-29.5 11.891-24.978-13.836a8.052 8.052 0 0 0-7.807 0l-23.176 12.836-11.454-10.848a8.065 8.065 0 0 0-9.373-1.232l-25.759 13.928h-10.71c5.475-7.035 8.752-15.859 8.777-25.428V55.766c0-13.477 10.965-24.441 24.44-24.441H364.45c-5.429 7.031-8.643 15.844-8.668 25.428V254.7c-54.433 12.505-95.164 61.308-95.164 119.478zm49.333-255.522a8.058 8.058 0 0 1-8.06 8.057H109.656a8.056 8.056 0 0 1-8.061-8.057 8.057 8.057 0 0 1 8.061-8.059h192.235a8.059 8.059 0 0 1 8.06 8.059zm0 51.317a8.061 8.061 0 0 1-8.06 8.059H109.656a8.06 8.06 0 0 1-8.061-8.059 8.06 8.06 0 0 1 8.061-8.061h192.235a8.06 8.06 0 0 1 8.06 8.061zm0 51.322a8.06 8.06 0 0 1-8.06 8.057H109.656a8.058 8.058 0 0 1-8.061-8.057 8.058 8.058 0 0 1 8.061-8.063h192.235a8.06 8.06 0 0 1 8.06 8.063zm-20.992 51.31a8.056 8.056 0 0 1-8.059 8.059H109.656c-4.454 0-8.061-3.605-8.061-8.059s3.606-8.059 8.061-8.059H280.9a8.057 8.057 0 0 1 8.059 8.059zm-35.417 51.317a8.055 8.055 0 0 1-8.057 8.057H109.656c-4.454 0-8.061-3.605-8.061-8.057s3.606-8.063 8.061-8.063h135.829c4.451 0 8.057 3.612 8.057 8.063zm-9.446 51.31a8.06 8.06 0 0 1-8.059 8.064H109.656a8.06 8.06 0 0 1-8.061-8.064c0-4.447 3.606-8.051 8.061-8.051h126.381c4.452.001 8.059 3.604 8.059 8.051zm79.017-1.054c0-4.449 3.606-8.061 8.056-8.061h44.005v-73.82a8.06 8.06 0 0 1 16.117 0v81.881a8.06 8.06 0 0 1-8.058 8.063H331.17a8.06 8.06 0 0 1-8.057-8.063z",fill:"#ffffff"})})}),Jt=()=>e.jsx("svg",{xmlns:"http://www.w3.org/2000/svg",width:"48",height:"48",viewBox:"0 0 480 480",children:e.jsx("g",{children:e.jsx("path",{d:"M72 320c-35.785 0-72 10.992-72 32v96c0 21.008 36.215 32 72 32s72-10.992 72-32v-96c0-21.008-36.215-32-72-32zm0 16c36.375 0 56 11.36 56 16s-19.625 16-56 16-56-11.36-56-16 19.625-16 56-16zm0 128c-36.375 0-56-11.36-56-16v-11.2A126.879 126.879 0 0 0 72 448a126.879 126.879 0 0 0 56-11.2V448c0 4.64-19.625 16-56 16zm0-32c-36.375 0-56-11.36-56-16v-11.2A126.879 126.879 0 0 0 72 416a126.879 126.879 0 0 0 56-11.2V416c0 4.64-19.625 16-56 16zm0-32c-36.375 0-56-11.36-56-16v-11.2A126.879 126.879 0 0 0 72 384a126.879 126.879 0 0 0 56-11.2V384c0 4.64-19.625 16-56 16zM240 256c-35.785 0-72 10.992-72 32v160c0 21.008 36.215 32 72 32s72-10.992 72-32V288c0-21.008-36.215-32-72-32zm0 16c36.375 0 56 11.36 56 16s-19.625 16-56 16-56-11.36-56-16 19.625-16 56-16zm0 192c-36.375 0-56-11.36-56-16v-11.2a126.879 126.879 0 0 0 56 11.2 126.879 126.879 0 0 0 56-11.2V448c0 4.64-19.625 16-56 16zm0-32c-36.375 0-56-11.36-56-16v-11.2a126.879 126.879 0 0 0 56 11.2 126.879 126.879 0 0 0 56-11.2V416c0 4.64-19.625 16-56 16zm0-32c-36.375 0-56-11.36-56-16v-11.2a126.879 126.879 0 0 0 56 11.2 126.879 126.879 0 0 0 56-11.2V384c0 4.64-19.625 16-56 16zm0-32c-36.375 0-56-11.36-56-16v-11.2a126.879 126.879 0 0 0 56 11.2 126.879 126.879 0 0 0 56-11.2V352c0 4.64-19.625 16-56 16zm0-32c-36.375 0-56-11.36-56-16v-11.2a126.879 126.879 0 0 0 56 11.2 126.879 126.879 0 0 0 56-11.2V320c0 4.64-19.625 16-56 16zM408 160c-35.785 0-72 10.992-72 32v256c0 21.008 36.215 32 72 32s72-10.992 72-32V192c0-21.008-36.215-32-72-32zm0 16c36.375 0 56 11.36 56 16s-19.625 16-56 16-56-11.36-56-16 19.625-16 56-16zm0 288c-36.375 0-56-11.36-56-16v-11.2a126.879 126.879 0 0 0 56 11.2 126.879 126.879 0 0 0 56-11.2V448c0 4.64-19.625 16-56 16zm0-32c-36.375 0-56-11.36-56-16v-11.2a126.879 126.879 0 0 0 56 11.2 126.879 126.879 0 0 0 56-11.2V416c0 4.64-19.625 16-56 16zm0-32c-36.375 0-56-11.36-56-16v-11.2a126.879 126.879 0 0 0 56 11.2 126.879 126.879 0 0 0 56-11.2V384c0 4.64-19.625 16-56 16zm0-32c-36.375 0-56-11.36-56-16v-11.2a126.879 126.879 0 0 0 56 11.2 126.879 126.879 0 0 0 56-11.2V352c0 4.64-19.625 16-56 16zm0-32c-36.375 0-56-11.36-56-16v-11.2a126.879 126.879 0 0 0 56 11.2 126.879 126.879 0 0 0 56-11.2V320c0 4.64-19.625 16-56 16zm0-32c-36.375 0-56-11.36-56-16v-11.2a126.879 126.879 0 0 0 56 11.2 126.879 126.879 0 0 0 56-11.2V288c0 4.64-19.625 16-56 16zm0-32c-36.375 0-56-11.36-56-16v-11.2a126.879 126.879 0 0 0 56 11.2 126.879 126.879 0 0 0 56-11.2V256c0 4.64-19.625 16-56 16zm0-32c-36.375 0-56-11.36-56-16v-11.2a126.879 126.879 0 0 0 56 11.2 126.879 126.879 0 0 0 56-11.2V224c0 4.64-19.625 16-56 16zM392 0v16h60.688l-152 152H132.992L2.727 281.977l10.546 12.046L139.008 184h168.304L464 27.312V88h16V0zm0 0",fill:"#ffffff"})})}),Gt=()=>{const{t}=te(),i=v(r=>r.customModal);return e.jsx(st,{rootClassName:"tgg-payment-confirm-modal-root",className:"tgg-payment-confirm-modal",getContainer:()=>document.querySelector(".tgg-app-grid"),maskClosable:!0,centered:!0,closeIcon:null,width:350,open:i==null?void 0:i.visible,footer:null,children:e.jsxs("div",{className:"tgg-modal-content",children:[e.jsx("div",{className:"tgg-modal-info-icon",children:e.jsx(Et,{})}),e.jsxs("div",{className:"tgg-modal-body",children:[e.jsx("div",{className:"tgg-modal-info-text",children:(i==null?void 0:i.bodyText)??""}),e.jsxs("div",{className:"tgg-modal-buttons",children:[e.jsx("button",{className:"tgg-modal-confirm-btn",onClick:i==null?void 0:i.onOk,children:t("general.confirm")}),e.jsx("button",{className:"tgg-modal-cancel-btn",onClick:i==null?void 0:i.onCancel,children:t("general.cancel")})]})]})]})})},Xt=V.div.attrs({className:"tgg-invoice-create-footer"})`
	height: 100%;
	width: 100%;

	.tgg-additional-actions {
		display: flex;

		width: 100%;
		height: 60px;

		.tgg-cancel-btn,
		.tgg-draft-btn {
			position: relative;

			width: 50%;

			outline: none;
			border: none;

			background-color: transparent;

			.tgg-label {
				color: rgba(255, 255, 255, 0.75);

				font-size: 1.15em;
				letter-spacing: 1px;
				text-transform: uppercase;
				transition: color 0.25s ease-in-out;
			}

			&:hover:not(:disabled) {
				cursor: pointer;

				.tgg-label {
					color: #fff;

					&:after {
						width: 100%;
					}
				}
			}

			&:disabled {
				cursor: not-allowed;

				.tgg-label {
					color: rgba(255, 255, 255, 0.5);
				}
			}
		}
	}

	.tgg-invoice-create-btn {
		height: 79px;
		width: 100%;

		background-color: transparent;
		outline: none;
		border: none;

		.tgg-label {
			position: relative;

			color: rgba(255, 255, 255, 0.85);
			font-size: 1.75em;
			letter-spacing: 1px;
			text-transform: uppercase;
			transition: color 0.25s ease-in-out;

			width: fit-content;

			margin: 0 auto;
			margin-top: 5px;

			&:after {
				content: '';

				position: absolute;
				bottom: 0;
				left: 50%;
				right: 50%;
				transform: translateX(-50%);

				width: 0;
				height: 2px;
				background-color: #fff;

				transition: width 0.2s linear;
			}
		}

		&:hover:not(:disabled) {
			cursor: pointer;

			.tgg-label {
				color: #fff;

				&:after {
					width: 100%;
				}
			}
		}

		&:disabled {
			cursor: not-allowed;

			.tgg-label {
				color: rgba(255, 255, 255, 0.5);
			}
		}
	}
`,Kt=({invoiceDetails:t,handleCreateInvoice:i,handleCancelInvoice:r})=>{const{t:c}=te(),[s,g]=f.useState(!1),j=v(u=>u.companyConfig),y=v(u=>u.menuType),d=v(u=>u.jobInfo),N=q(u=>u.setMenuType);f.useEffect(()=>{var u;t!=null&&t.recipientId&&(t!=null&&t.recipientName)&&(t!=null&&t.sender)&&(t!=null&&t.senderId)&&(t!=null&&t.senderName)&&(t!=null&&t.total)&&((u=t==null?void 0:t.items)==null?void 0:u.length)>0?g(!0):g(!1)},[t]);const x=()=>{const u=j==null?void 0:j.create;return!!(u!=null&&u.includes("__personal"))},_=()=>{const u=j==null?void 0:j.create,l=d==null?void 0:d.grade.level;return!!(u!=null&&u.includes("-1")||l&&(u!=null&&u.includes(l)))},I=()=>{y===D.Personal?N(D.Business):N(D.Personal)};return e.jsxs(Xt,{children:[e.jsx("button",{className:"tgg-invoice-create-btn",disabled:!s,onClick:i,children:e.jsx("div",{className:"tgg-label",children:c("general.create")})}),e.jsxs("div",{className:"tgg-additional-actions",children:[e.jsx("button",{className:"tgg-cancel-btn",onClick:r,children:e.jsx("div",{className:"tgg-label",children:c("general.cancel")})}),_()&&x()&&e.jsx("button",{className:"tgg-draft-btn",onClick:I,children:e.jsx("div",{className:"tgg-label",children:y===D.Business?c("invoice.personal"):c("invoice.society")})})]})]})},ea=[{value:"all",label:"All"},{value:"byMe",label:"Created by me"},{value:"received",label:"Received"},{value:"police",label:"Police Department"},{value:"mechanic",label:"Mechanic Shop"},{value:"ambulance",label:"Ambulance Service"},{value:"taxi",label:"Taxi Service"},{value:"cardealer",label:"Car Dealership"}],Me=[{id:84,items:[{key:"speeding",label:"Speeding",price:100,priceChange:!1,quantity:1,quantityChange:!1},{key:"parking",label:"Parking",price:25,priceChange:!1,quantity:1,quantityChange:!1}],notes:"Police fine for speeding in a no-parking zone.",senderId:"SGP07132",senderName:"John Malik",sender:"__personal",senderCompanyName:"Law Enforcement",recipientId:"BZQ08355",recipientName:"Nick Walker",status:"not_accepted",taxPercentage:10,timestamp:1714405699e3,total:125,uuid:"LSA83000000000"},{id:83,items:[{key:"cop-bait",label:"Cop Bait",price:150,priceChange:!0,quantity:1,quantityChange:!0}],recipientId:"SGP07132",recipientName:"Alis Wright",sender:"police",senderCompanyName:"Law Enforcement",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1714405686e3,total:150,uuid:"LSA83000000000"},{id:82,items:[{key:"oil-change",label:"Oil Change",price:25,priceChange:!1,quantity:1,quantityChange:!1}],notes:"Periodic maintenance.",recipientId:"SGP07132",recipientName:"John Speed",sender:"mechanic",senderCompanyName:"LS Customs",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1714405363e3,total:25,uuid:"LSA10000000000"},{id:81,items:[{key:"speeding",label:"Speeding",price:100,priceChange:!1,quantity:1,quantityChange:!1}],notes:"",recipientId:"SGP07132",recipientName:"Second Debugov",sender:"police",senderCompanyName:"Law Enforcement",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:171440531e4,total:100,uuid:"LSA10000000000"},{id:8123,items:[{key:"speeding",label:"Speeding",price:100,priceChange:!1,quantity:1,quantityChange:!1}],notes:"test",recipientId:"SGP07132",recipientName:"Second Debugov",sender:"police",senderCompanyName:"Law Enforcement",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:171440531e4,total:100,uuid:"LSA10000000000"},{id:8121243,items:[{key:"speeding",label:"Speeding",price:100,priceChange:!1,quantity:1,quantityChange:!1}],notes:"test",recipientId:"SGP07132",recipientName:"Second Debugov",sender:"police",senderCompanyName:"Law Enforcement",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:171440531e4,total:100,uuid:"LSA10000000000"},{id:121243,items:[{key:"speeding",label:"Speeding",price:100,priceChange:!1,quantity:1,quantityChange:!1}],notes:"test",recipientId:"SGP07132",recipientName:"Second Debugov",sender:"police",senderCompanyName:"Law Enforcement",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:171440531e4,total:100,uuid:"LSA10000000000"},{id:12121243,items:[{key:"speeding",label:"Speeding",price:100,priceChange:!1,quantity:1,quantityChange:!1}],notes:"test",recipientId:"SGP07132",recipientName:"Second Debugov",sender:"police",senderCompanyName:"Law Enforcement",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:171440531e4,total:100,uuid:"LSA10000000000"},{id:1217243,items:[{key:"speeding",label:"Speeding",price:100,priceChange:!1,quantity:1,quantityChange:!1}],notes:"test",recipientId:"SGP07132",recipientName:"Second Debugov",sender:"police",senderCompanyName:"Law Enforcement",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:171440531e4,total:100,uuid:"LSA10000000000"}],ta=[{id:1,items:[{key:"coca-cola",label:"Coca-Cola",price:109,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ83887",recipientName:"Customer 1",sender:"__personal",senderId:"BZQ0832525",senderName:"Nick Walker",status:"rejected",taxPercentage:10,timestamp:1712918870124,total:533,uuid:"LSA000000000000001"},{id:2,items:[{key:"coca-cola",label:"Coca-Cola",price:109,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:97,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ83887",recipientName:"Customer 2",sender:"__personal",senderId:"steam:110000100000000",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:se().valueOf(),total:303,uuid:"LSA000000000000002"},{id:3,items:[{key:"coca-cola",label:"Coca-Cola",price:118,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:50,quantity:3,priceChange:!1}],recipientId:"BZQ55187",recipientName:"Customer 3",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"cancelled",taxPercentage:10,timestamp:1712918870124,total:268,uuid:"LSA000000000000003"},{id:4,items:[{key:"coca-cola",label:"Coca-Cola",price:117,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:95,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ40828",recipientName:"Customer 4",sender:"mechanic",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:402,uuid:"LSA000000000000004"},{id:5,items:[{key:"coca-cola",label:"Coca-Cola",price:125,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:71,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ38287",recipientName:"Customer 5",sender:"mechanic",senderCompanyName:"Mechanic Shop",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:321,uuid:"LSA000000000000005"},{id:6,items:[{key:"coca-cola",label:"Coca-Cola",price:133,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:50,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ41331",recipientName:"Customer 6",sender:"mechanic",senderCompanyName:"Mechanic Shop",senderId:"BZQ08355",senderName:"Nick Walker",status:"cancelled",taxPercentage:10,timestamp:1712918870124,total:582,uuid:"LSA000000000000006"},{id:7,items:[{key:"coca-cola",label:"Coca-Cola",price:104,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:88,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ55961",recipientName:"Customer 7",sender:"mechaninc",senderCompanyName:"Mechanic Shop",senderId:"BZQ08355",senderName:"Nick Walker",status:"cancelled",taxPercentage:10,timestamp:1712918870124,total:664,uuid:"LSA000000000000007"},{id:8,items:[{key:"coca-cola",label:"Coca-Cola",price:145,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:92,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ82883",recipientName:"Customer 8",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:421,uuid:"LSA000000000000008"},{id:9,items:[{key:"coca-cola",label:"Coca-Cola",price:128,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:78,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ94256",recipientName:"Customer 9",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:568,uuid:"LSA000000000000009"},{id:10,items:[{key:"coca-cola",label:"Coca-Cola",price:124,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:94,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ48636",recipientName:"Customer 10",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:406,uuid:"LSA000000000000010"},{id:11,items:[{key:"coca-cola",label:"Coca-Cola",price:136,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:60,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ88036",recipientName:"Customer 11",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:196,uuid:"LSA000000000000011"},{id:12,items:[{key:"coca-cola",label:"Coca-Cola",price:146,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:84,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ24960",recipientName:"Customer 12",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:752,uuid:"LSA000000000000012"},{id:13,items:[{key:"coca-cola",label:"Coca-Cola",price:137,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:66,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ56206",recipientName:"Customer 13",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:340,uuid:"LSA000000000000013"},{id:14,items:[{key:"coca-cola",label:"Coca-Cola",price:112,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:57,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ51165",recipientName:"Customer 14",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:338,uuid:"LSA000000000000014"},{id:15,items:[{key:"coca-cola",label:"Coca-Cola",price:136,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:54,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ49116",recipientName:"Customer 15",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:190,uuid:"LSA000000000000015"},{id:16,items:[{key:"coca-cola",label:"Coca-Cola",price:101,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:75,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ79982",recipientName:"Customer 16",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:378,uuid:"LSA000000000000016"},{id:17,items:[{key:"coca-cola",label:"Coca-Cola",price:110,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:59,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ27854",recipientName:"Customer 17",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:566,uuid:"LSA000000000000017"},{id:18,items:[{key:"coca-cola",label:"Coca-Cola",price:102,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:69,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ55439",recipientName:"Customer 18",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:546,uuid:"LSA000000000000018"},{id:19,items:[{key:"coca-cola",label:"Coca-Cola",price:132,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:75,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ35206",recipientName:"Customer 19",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:489,uuid:"LSA000000000000019"},{id:20,items:[{key:"coca-cola",label:"Coca-Cola",price:128,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:58,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ26202",recipientName:"Customer 20",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:628,uuid:"LSA000000000000020"},{id:21,items:[{key:"coca-cola",label:"Coca-Cola",price:138,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:55,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ33364",recipientName:"Customer 21",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:607,uuid:"LSA000000000000021"},{id:22,items:[{key:"coca-cola",label:"Coca-Cola",price:100,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:95,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ15764",recipientName:"Customer 22",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:490,uuid:"LSA000000000000022"},{id:23,items:[{key:"coca-cola",label:"Coca-Cola",price:130,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:81,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ14864",recipientName:"Customer 23",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:584,uuid:"LSA000000000000023"},{id:24,items:[{key:"coca-cola",label:"Coca-Cola",price:105,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:56,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ38487",recipientName:"Customer 24",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:266,uuid:"LSA000000000000024"},{id:25,items:[{key:"coca-cola",label:"Coca-Cola",price:148,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:91,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ66980",recipientName:"Customer 25",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:626,uuid:"LSA000000000000025"},{id:26,items:[{key:"coca-cola",label:"Coca-Cola",price:134,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:85,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ14351",recipientName:"Customer 26",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:876,uuid:"LSA000000000000026"},{id:27,items:[{key:"coca-cola",label:"Coca-Cola",price:105,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:78,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ35417",recipientName:"Customer 27",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:654,uuid:"LSA000000000000027"},{id:28,items:[{key:"coca-cola",label:"Coca-Cola",price:110,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:51,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ88021",recipientName:"Customer 28",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:314,uuid:"LSA000000000000028"},{id:29,items:[{key:"coca-cola",label:"Coca-Cola",price:120,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:55,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ76116",recipientName:"Customer 29",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:535,uuid:"LSA000000000000029"},{id:30,items:[{key:"coca-cola",label:"Coca-Cola",price:132,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:91,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ76712",recipientName:"Customer 30",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:487,uuid:"LSA000000000000030"},{id:31,items:[{key:"coca-cola",label:"Coca-Cola",price:124,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:52,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ67740",recipientName:"Customer 31",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:528,uuid:"LSA000000000000031"},{id:32,items:[{key:"coca-cola",label:"Coca-Cola",price:108,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:71,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ70558",recipientName:"Customer 32",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:358,uuid:"LSA000000000000032"},{id:33,items:[{key:"coca-cola",label:"Coca-Cola",price:117,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:98,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ43179",recipientName:"Customer 33",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:547,uuid:"LSA000000000000033"},{id:34,items:[{key:"coca-cola",label:"Coca-Cola",price:116,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:93,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ85237",recipientName:"Customer 34",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:557,uuid:"LSA000000000000034"},{id:35,items:[{key:"coca-cola",label:"Coca-Cola",price:138,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:73,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ46461",recipientName:"Customer 35",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:284,uuid:"LSA000000000000035"},{id:36,items:[{key:"coca-cola",label:"Coca-Cola",price:139,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:62,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ95928",recipientName:"Customer 36",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:742,uuid:"LSA000000000000036"},{id:37,items:[{key:"coca-cola",label:"Coca-Cola",price:125,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:92,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ46128",recipientName:"Customer 37",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:651,uuid:"LSA000000000000037"},{id:38,items:[{key:"coca-cola",label:"Coca-Cola",price:125,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:94,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ36624",recipientName:"Customer 38",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:782,uuid:"LSA000000000000038"},{id:39,items:[{key:"coca-cola",label:"Coca-Cola",price:117,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:89,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ93154",recipientName:"Customer 39",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:646,uuid:"LSA000000000000039"},{id:40,items:[{key:"coca-cola",label:"Coca-Cola",price:138,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:71,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ38916",recipientName:"Customer 40",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:698,uuid:"LSA000000000000040"},{id:41,items:[{key:"coca-cola",label:"Coca-Cola",price:133,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:77,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ86636",recipientName:"Customer 41",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:287,uuid:"LSA000000000000041"},{id:42,items:[{key:"coca-cola",label:"Coca-Cola",price:113,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:85,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ92159",recipientName:"Customer 42",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:396,uuid:"LSA000000000000042"},{id:43,items:[{key:"coca-cola",label:"Coca-Cola",price:123,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:64,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ89507",recipientName:"Customer 43",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:379,uuid:"LSA000000000000043"},{id:44,items:[{key:"coca-cola",label:"Coca-Cola",price:125,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:83,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ20324",recipientName:"Customer 44",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:458,uuid:"LSA000000000000044"},{id:45,items:[{key:"coca-cola",label:"Coca-Cola",price:125,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:65,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ94158",recipientName:"Customer 45",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:190,uuid:"LSA000000000000045"},{id:46,items:[{key:"coca-cola",label:"Coca-Cola",price:100,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:65,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ31673",recipientName:"Customer 46",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:530,uuid:"LSA000000000000046"},{id:47,items:[{key:"coca-cola",label:"Coca-Cola",price:140,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:85,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ48914",recipientName:"Customer 47",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:620,uuid:"LSA000000000000047"},{id:48,items:[{key:"coca-cola",label:"Coca-Cola",price:111,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:98,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ92721",recipientName:"Customer 48",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:836,uuid:"LSA000000000000048"},{id:49,items:[{key:"coca-cola",label:"Coca-Cola",price:132,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:90,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ46782",recipientName:"Customer 49",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:576,uuid:"LSA000000000000049"},{id:50,items:[{key:"coca-cola",label:"Coca-Cola",price:119,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:88,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ13490",recipientName:"Customer 50",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:295,uuid:"LSA000000000000050"},{id:51,items:[{key:"coca-cola",label:"Coca-Cola",price:148,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:50,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ51542",recipientName:"Customer 51",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:496,uuid:"LSA000000000000051"},{id:52,items:[{key:"coca-cola",label:"Coca-Cola",price:145,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:99,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ82250",recipientName:"Customer 52",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:442,uuid:"LSA000000000000052"},{id:53,items:[{key:"coca-cola",label:"Coca-Cola",price:118,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:83,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ20591",recipientName:"Customer 53",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:686,uuid:"LSA000000000000053"},{id:54,items:[{key:"coca-cola",label:"Coca-Cola",price:109,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:74,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ46992",recipientName:"Customer 54",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:401,uuid:"LSA000000000000054"},{id:55,items:[{key:"coca-cola",label:"Coca-Cola",price:130,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:64,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ59828",recipientName:"Customer 55",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:258,uuid:"LSA000000000000055"},{id:56,items:[{key:"coca-cola",label:"Coca-Cola",price:144,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:63,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ76445",recipientName:"Customer 56",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:207,uuid:"LSA000000000000056"},{id:57,items:[{key:"coca-cola",label:"Coca-Cola",price:131,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:60,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ65432",recipientName:"Customer 57",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:311,uuid:"LSA000000000000057"},{id:58,items:[{key:"coca-cola",label:"Coca-Cola",price:138,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:88,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ15989",recipientName:"Customer 58",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:540,uuid:"LSA000000000000058"},{id:59,items:[{key:"coca-cola",label:"Coca-Cola",price:122,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:81,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ93664",recipientName:"Customer 59",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:731,uuid:"LSA000000000000059"},{id:60,items:[{key:"coca-cola",label:"Coca-Cola",price:127,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:51,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ53772",recipientName:"Customer 60",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:559,uuid:"LSA000000000000060"},{id:61,items:[{key:"coca-cola",label:"Coca-Cola",price:101,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:66,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ57320",recipientName:"Customer 61",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:268,uuid:"LSA000000000000061"},{id:62,items:[{key:"coca-cola",label:"Coca-Cola",price:122,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:90,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ27736",recipientName:"Customer 62",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:334,uuid:"LSA000000000000062"},{id:63,items:[{key:"coca-cola",label:"Coca-Cola",price:136,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:76,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ24133",recipientName:"Customer 63",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:712,uuid:"LSA000000000000063"},{id:64,items:[{key:"coca-cola",label:"Coca-Cola",price:141,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:84,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ41323",recipientName:"Customer 64",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:732,uuid:"LSA000000000000064"},{id:65,items:[{key:"coca-cola",label:"Coca-Cola",price:117,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:66,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ95766",recipientName:"Customer 65",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:183,uuid:"LSA000000000000065"},{id:66,items:[{key:"coca-cola",label:"Coca-Cola",price:118,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:73,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ82955",recipientName:"Customer 66",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:545,uuid:"LSA000000000000066"},{id:67,items:[{key:"coca-cola",label:"Coca-Cola",price:104,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:67,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ76706",recipientName:"Customer 67",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:483,uuid:"LSA000000000000067"},{id:68,items:[{key:"coca-cola",label:"Coca-Cola",price:122,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:53,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ92141",recipientName:"Customer 68",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:297,uuid:"LSA000000000000068"},{id:69,items:[{key:"coca-cola",label:"Coca-Cola",price:137,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:79,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ17913",recipientName:"Customer 69",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:590,uuid:"LSA000000000000069"},{id:70,items:[{key:"coca-cola",label:"Coca-Cola",price:106,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:98,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ79595",recipientName:"Customer 70",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:612,uuid:"LSA000000000000070"},{id:71,items:[{key:"coca-cola",label:"Coca-Cola",price:134,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:86,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ15338",recipientName:"Customer 71",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:478,uuid:"LSA000000000000071"},{id:72,items:[{key:"coca-cola",label:"Coca-Cola",price:125,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:86,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ29043",recipientName:"Customer 72",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:594,uuid:"LSA000000000000072"},{id:73,items:[{key:"coca-cola",label:"Coca-Cola",price:117,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:83,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ35460",recipientName:"Customer 73",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:683,uuid:"LSA000000000000073"},{id:74,items:[{key:"coca-cola",label:"Coca-Cola",price:116,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:83,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ64048",recipientName:"Customer 74",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:282,uuid:"LSA000000000000074"},{id:75,items:[{key:"coca-cola",label:"Coca-Cola",price:134,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:76,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ79344",recipientName:"Customer 75",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:688,uuid:"LSA000000000000075"},{id:76,items:[{key:"coca-cola",label:"Coca-Cola",price:131,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:80,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ63825",recipientName:"Customer 76",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:604,uuid:"LSA000000000000076"},{id:77,items:[{key:"coca-cola",label:"Coca-Cola",price:143,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:75,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ94010",recipientName:"Customer 77",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:368,uuid:"LSA000000000000077"},{id:78,items:[{key:"coca-cola",label:"Coca-Cola",price:102,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:60,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ80869",recipientName:"Customer 78",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:162,uuid:"LSA000000000000078"},{id:79,items:[{key:"coca-cola",label:"Coca-Cola",price:125,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:55,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ98126",recipientName:"Customer 79",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:345,uuid:"LSA000000000000079"},{id:80,items:[{key:"coca-cola",label:"Coca-Cola",price:127,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:75,quantity:1,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ54410",recipientName:"Customer 80",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:456,uuid:"LSA000000000000080"},{id:81,items:[{key:"coca-cola",label:"Coca-Cola",price:100,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:83,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ99854",recipientName:"Customer 81",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:549,uuid:"LSA000000000000081"},{id:82,items:[{key:"coca-cola",label:"Coca-Cola",price:127,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:83,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ18638",recipientName:"Customer 82",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:674,uuid:"LSA000000000000082"},{id:83,items:[{key:"coca-cola",label:"Coca-Cola",price:143,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:70,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ50956",recipientName:"Customer 83",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:782,uuid:"LSA000000000000083"},{id:84,items:[{key:"coca-cola",label:"Coca-Cola",price:104,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:59,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ39139",recipientName:"Customer 84",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:340,uuid:"LSA000000000000084"},{id:85,items:[{key:"coca-cola",label:"Coca-Cola",price:108,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:99,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ54564",recipientName:"Customer 85",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:405,uuid:"LSA000000000000085"},{id:86,items:[{key:"coca-cola",label:"Coca-Cola",price:104,quantity:2,priceChange:!1},{key:"pepsi",label:"Pepsi",price:79,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ52013",recipientName:"Customer 86",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:366,uuid:"LSA000000000000086"},{id:87,items:[{key:"coca-cola",label:"Coca-Cola",price:149,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:76,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ67711",recipientName:"Customer 87",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:675,uuid:"LSA000000000000087"},{id:88,items:[{key:"coca-cola",label:"Coca-Cola",price:101,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:95,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ57018",recipientName:"Customer 88",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:689,uuid:"LSA000000000000088"},{id:89,items:[{key:"coca-cola",label:"Coca-Cola",price:100,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:60,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ12737",recipientName:"Customer 89",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:340,uuid:"LSA000000000000089"},{id:90,items:[{key:"coca-cola",label:"Coca-Cola",price:131,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:72,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ96029",recipientName:"Customer 90",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:609,uuid:"LSA000000000000090"},{id:91,items:[{key:"coca-cola",label:"Coca-Cola",price:127,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:68,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ18126",recipientName:"Customer 91",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:399,uuid:"LSA000000000000091"},{id:92,items:[{key:"coca-cola",label:"Coca-Cola",price:105,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:99,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ16055",recipientName:"Customer 92",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:711,uuid:"LSA000000000000092"},{id:93,items:[{key:"coca-cola",label:"Coca-Cola",price:142,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:50,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ76269",recipientName:"Customer 93",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:718,uuid:"LSA000000000000093"},{id:94,items:[{key:"coca-cola",label:"Coca-Cola",price:102,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:82,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ66717",recipientName:"Customer 94",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:654,uuid:"LSA000000000000094"},{id:95,items:[{key:"coca-cola",label:"Coca-Cola",price:134,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:83,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ66365",recipientName:"Customer 95",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:300,uuid:"LSA000000000000095"},{id:96,items:[{key:"coca-cola",label:"Coca-Cola",price:125,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:52,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ91286",recipientName:"Customer 96",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:229,uuid:"LSA000000000000096"},{id:97,items:[{key:"coca-cola",label:"Coca-Cola",price:107,quantity:3,priceChange:!1},{key:"pepsi",label:"Pepsi",price:62,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ46141",recipientName:"Customer 97",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:445,uuid:"LSA000000000000097"},{id:98,items:[{key:"coca-cola",label:"Coca-Cola",price:121,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:64,quantity:2,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ55646",recipientName:"Customer 98",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:612,uuid:"LSA000000000000098"},{id:99,items:[{key:"coca-cola",label:"Coca-Cola",price:122,quantity:1,priceChange:!1},{key:"pepsi",label:"Pepsi",price:64,quantity:3,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ16574",recipientName:"Customer 99",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"unpaid",taxPercentage:10,timestamp:1712918870124,total:314,uuid:"LSA000000000000099"},{id:100,items:[{key:"coca-cola",label:"Coca-Cola",price:120,quantity:4,priceChange:!1},{key:"pepsi",label:"Pepsi",price:86,quantity:4,priceChange:!1}],notes:"Auto-generated invoice",recipientId:"BZQ25158",recipientName:"Customer 100",sender:"__personal",senderId:"BZQ08355",senderName:"Nick Walker",status:"paid",taxPercentage:10,timestamp:1712918870124,total:824,uuid:"LSA000000000000100"}],ce=()=>Math.floor(Math.random()*1e4),Ee={totalExpectedIncome:0,graphData:[{date:"May 07, 24",total:ce()},{date:"May 06, 24",total:ce()},{date:"May 05, 24",total:ce()},{date:"May 04, 24",total:ce()},{date:"May 03, 24",total:23692},{date:"May 02, 24",total:275},{date:"May 01, 24",total:ce()},{date:"Apr 30, 24",total:650},{date:"Apr 29, 24",total:150},{date:"Apr 28, 24",total:ce()},{date:"Apr 27, 24",total:ce()},{date:"Apr 26, 24",total:ce()},{date:"Apr 25, 24",total:ce()},{date:"Apr 24, 24",total:ce()},{date:"Apr 23, 24",total:ce()}],totalIncome:8767,totalInvoices:20,recentPayments:ta.splice(0,25)},aa={name:"mechanic",label:"LS Customs",isboss:!0,grade:{level:"4",name:"Manager"},payment:150},ia={identifier:"BZQ08355",fullName:"Nick Walker",taxPercentage:5,money:{cash:371215,bank:1177169,crypto:0}},sa=[{citizenId:"steam:110000100000002",name:"John Smith",id:2},{citizenId:"steam:110000100000004",name:"John Doe",id:4},{citizenId:"steam:110000100000005",name:"Jane Doe",id:5},{citizenId:"steam:110000100000007",name:"Jane Smith",id:7}],na={name:"Law Enforcement",jobIdentifier:"police",create:["-1","__personal"],cancel:["3","4"],acceptFirst:!1,taxPercentage:10,allowCustomItems:!0,defaultInvoiceItems:[{key:"speeding",label:"Speeding",price:100,quantity:1,priceChange:!1,quantityChange:!1},{key:"parking",label:"Parking",price:25,quantity:1,priceChange:!1,quantityChange:!1},{key:"cop-bait",label:"Cop Bait",price:150,quantity:1,priceChange:!1,quantityChange:!1},{key:"illegal-u-turn",label:"Illegal U-turn",price:75,quantity:1,priceChange:!1,quantityChange:!1},{key:"running-red-light",label:"Running Red Light",price:200,quantity:1,priceChange:!1,quantityChange:!1},{key:"failure-to-yield",label:"Failure to Yield",price:80,quantity:1,priceChange:!1,quantityChange:!1},{key:"expired-tags",label:"Expired Tags",price:50,quantity:1,priceChange:!1,quantityChange:!1},{key:"illegal-parking",label:"Illegal Parking",price:40,quantity:1,priceChange:!1,quantityChange:!1},{key:"no-seatbelt",label:"No Seatbelt",price:30,quantity:1,priceChange:!1,quantityChange:!1},{key:"reckless-driving",label:"Reckless Driving",price:250,quantity:1,priceChange:!1,quantityChange:!1},{key:"tailgating",label:"Tailgating",price:90,quantity:1,priceChange:!1,quantityChange:!1},{key:"failure-to-signal",label:"Failure to Signal",price:60,quantity:1,priceChange:!1,quantityChange:!1},{key:"illegal-lane-change",label:"Illegal Lane Change",price:70,quantity:1,priceChange:!1,quantityChange:!1},{key:"driving-without-license",label:"Driving Without License",price:150,quantity:1,priceChange:!1,quantityChange:!1},{key:"expired-insurance",label:"Expired Insurance",price:100,quantity:1,priceChange:!1,quantityChange:!1},{key:"overloading-vehicle",label:"Overloading Vehicle",price:120,quantity:1,priceChange:!1,quantityChange:!1},{key:"littering",label:"Littering",price:50,quantity:1,priceChange:!1,quantityChange:!1},{key:"illegal-horn-use",label:"Illegal Horn Use",price:40,quantity:1,priceChange:!1,quantityChange:!1},{key:"engine-revving",label:"Engine Revving",price:75,quantity:1,priceChange:!1,quantityChange:!1},{key:"wrong-way-driving",label:"Wrong-Way Driving",price:180,quantity:1,priceChange:!1,quantityChange:!1},{key:"blocking-intersection",label:"Blocking Intersection",price:65,quantity:1,priceChange:!1,quantityChange:!1},{key:"distracted-driving",label:"Distracted Driving",price:85,quantity:1,priceChange:!1,quantityChange:!1},{key:"driving-without-headlights",label:"Driving Without Headlights",price:60,quantity:1,priceChange:!1,quantityChange:!1}]},ra={language:"en",showFullName:!0,currencySymbol:"$",allowOverdraft:!0,overdraftLimit:1e3,dateFormat:"DD-MM-YYYY",currencyFormat:"{amount}$",highlightNewInvoiceDuration:30,dateTimeFormat:"DD-MM-YYYY HH:mm",societyFilters:ea},oa=V.div.attrs({className:"tgg-create-invoice-form"})`
	display: flex;
	flex-direction: column;
	gap: 0.5em;
	height: 100%;
	padding: 1.5em 0.75em 1em 0.75em;

	.tgg-invoice-header {
		display: flex;
		justify-content: space-between;
		align-items: center;

		gap: 2.5em;

		.tgg-invoice-subtitle {
			font-size: 1.1em;
			font-weight: 600;
			text-align: start;
		}

		.tgg-type-switch-icon {
			display: flex;
			justify-content: center;
			align-items: center;

			transition: transform 0.2s ease-in-out;
			&:hover {
				cursor: pointer;
				transform: scale(1.1);
			}

			svg {
				color: #000;
				font-size: 1.35em;
			}
		}
	}

	.tgg-invoice-body {
		display: flex;
		flex-direction: column;
		gap: 0.25em;
		overflow: hidden;

		.tgg-invoice-row {
			display: flex;
			justify-content: space-between;
			align-items: center;

			gap: 1em;

			.tgg-invoice-label {
				font-size: 1em;
				color: #000;
				font-weight: 600;

				white-space: nowrap;
			}

			.tgg-invoice-value {
				font-size: 1em;
				color: #000;

				white-space: nowrap;
			}

			.tgg-select {
				text-align: end;

				&.ant-select-focused {
					border-bottom: 1px solid rgba(63, 63, 63, 0.05);
				}

				.ant-select-selection-item {
					font-family: 'Poppins', sans-serif;
					font-size: 1.1em;
					color: #000;
				}
			}

			.tgg-add-item-btn {
				display: flex;
				justify-content: center;
				align-items: center;

				transition: transform 0.2s;
				&:hover {
					cursor: pointer;

					transform: scale(1.2);
				}
			}
		}

		.tgg-lighter {
			.tgg-invoice-label,
			.tgg-invoice-value {
				color: rgba(50, 50, 50, 0.75);
			}
		}

		.tgg-items-container {
			display: flex;
			flex-direction: column;

			width: 100%;

			height: 230px;

			overflow-y: auto;
			overflow-x: hidden;

			margin-top: 0.15em;
			padding-right: 0.25em;

			row-gap: 0.5em;

			::-webkit-scrollbar {
				width: 2px;
				height: 2px;
			}

			::-webkit-scrollbar-button {
				width: 0px;
				height: 0px;
			}

			::-webkit-scrollbar-thumb {
				background: #b0b0b0;
				border: 0px none #ffffff;
				border-radius: 50px;
			}

			::-webkit-scrollbar-thumb:hover {
				background: #ffffff;
			}

			::-webkit-scrollbar-thumb:active {
				background: #01e01f;
			}

			::-webkit-scrollbar-track {
				background: #ffffff;
				border: 0px none #ffffff;
				border-radius: 50px;
			}

			::-webkit-scrollbar-track:hover {
				background: #666666;
			}

			::-webkit-scrollbar-track:active {
				background: #797979;
			}

			::-webkit-scrollbar-corner {
				background: transparent;
			}

			#newItemBtn.tgg-disabled {
				opacity: 0.25;
			}

			.tgg-item {
				width: 100%;

				.tgg-remove-item-btn,
				.tgg-add-item-btn {
					display: flex;
					justify-content: center;
					align-items: center;

					width: 10%;

					transition: transform 0.2s;
					&:hover {
						cursor: pointer;
						transform: scale(1.2);
					}
				}

				.tgg-remove-item-btn {
					svg {
						color: #c90000;
					}
				}

				.tgg-add-item-btn {
					svg {
						color: green;
					}
				}

				.ant-space-compact {
					display: flex;
				}

				.ant-input-number-group-addon {
					padding: 0 0.25em;
				}

				.ant-select-selection-item {
					min-width: 100%;
					text-align: start;
				}
			}
		}

		.tgg-summary {
			display: flex;
			flex-direction: column;

			gap: 0;

			.tgg-invoice-label {
				font-size: 1em;
				color: #000;
				font-weight: 600;
				width: 100%;
				text-align: start;
			}

			.tgg-invoice-value {
				font-size: 0.95em;
				color: #000;
				text-align: start;
			}

			.tgg-notes-input {
				margin-bottom: 1em;
				textarea {
					resize: none;
				}
			}
		}

		.tgg-divider-dashed {
			height: 1px;
			width: 100%;
			border-top: 2px dashed rgba(97, 97, 97, 0.5);
			margin: 0.35em 0;
		}
	}
`,la=({invoiceDetails:t,setInvoiceDetails:i})=>{var Ne,Oe,Fe;const{t:r}=te(),c=f.useRef(null),[s,g]=f.useState(null),[j,y]=f.useState(),[d,N]=f.useState(0),[x,_]=f.useState(0),[I,u]=f.useState(0),[l,$]=f.useState(0),[w,k]=f.useState([]),A=v(o=>o.settingsConfig),n=v(o=>o.companyConfig),S=v(o=>o.playerData),b=v(o=>o.menuType),Z=v(o=>o.jobInfo),U=v(o=>o.filters),T=b===D.Business?n==null?void 0:n.defaultInvoiceItems:[],X=n==null?void 0:n.allowCustomItems,pe=A.currencySymbol,oe=A.currencyFormat,he=A.dateFormat,ge=v(o=>o.createInvoiceModalOpen),ae=q(o=>o.setMenuType),ie=q(o=>o.setFlexOasisData);f.useEffect(()=>{ge===re.Open&&(G("billing:get-available-recipients",null,void 0,sa).then(o=>{k(o)}),U.type==Y.Society&&ke()?ae(D.Business):M()&&ae(D.Personal))},[ge]),f.useEffect(()=>{const o=c.current;o&&(o.scrollTop=o.scrollHeight)},[(Ne=t==null?void 0:t.items)==null?void 0:Ne.length]),f.useEffect(()=>{var o;((o=t==null?void 0:t.items)==null?void 0:o.length)>0&&me()},[t==null?void 0:t.items,(Oe=t==null?void 0:t.items)==null?void 0:Oe.length]),f.useEffect(()=>{const o=b==D.Personal?(S==null?void 0:S.taxPercentage)??0:(n==null?void 0:n.taxPercentage)??0;i({...t,sender:b==D.Personal?"__personal":(Z==null?void 0:Z.name)??"",senderCompanyName:b==D.Personal?"":Z==null?void 0:Z.label,items:[],total:0,notes:"",recipientId:"",recipientName:"",taxPercentage:o}),N(0),u(0),_(0),$(o)},[b]);const me=()=>{var z;let o=0,B=0,Q=0;(z=t==null?void 0:t.items)==null||z.forEach(R=>{o+=R.price*R.quantity}),l&&l>0&&(B=o*(l/100),N(+(o==null?void 0:o.toFixed(2))),u(+(B==null?void 0:B.toFixed(2)))),Q=o+B,_(+(Q==null?void 0:Q.toFixed(2))),i({...t,total:+(o==null?void 0:o.toFixed(2))})},fe=()=>se().format(he),L=(o,B,Q,z,R,Le)=>{let be=[...t.items];const Ke=o??(s==null?void 0:s.key)??"",$e=be.findIndex(Be=>Be.key===Ke);if($e!==-1){if(!be[$e].quantityChange){ie({status:!0,message:"itemQuantityDisabled"});return}be[$e].quantity+=1}else{const Be={key:o??(s==null?void 0:s.key)??"",label:B??(s==null?void 0:s.label)??"",price:Q??(s==null?void 0:s.price)??-1,quantity:z??(s==null?void 0:s.quantity)??1,priceChange:R??(s==null?void 0:s.priceChange)??!1,quantityChange:Le??(s==null?void 0:s.quantityChange)??!1};be=[...be,Be]}i({...t,items:be}),g(null)},H=o=>{var Q;if(((Q=t==null?void 0:t.items)==null?void 0:Q.length)===1)return;const B=[...t.items];B.splice(o,1),i({...t,items:B})},W=(o,B)=>{const Q=[...t.items],z=T==null?void 0:T.find(R=>R.key===o);z&&(Q[B]={key:z.key,label:z.label,price:z.price,quantity:z.quantity,priceChange:z.priceChange},i({...t,items:Q}))},ue=(o,B)=>{const Q=[...t.items];Q[B].price=o,i({...t,items:Q})},m=(o,B)=>{const Q=[...t.items];Q[B].quantity=o,i({...t,items:Q})},F=o=>{const B=w.find(Q=>Q.citizenId===o);B&&i({...t,recipientId:B.citizenId,recipientName:B.name})},le=o=>{const B=o;y(!1);const Q=T==null?void 0:T.find(z=>z.key===B);if(!Q)g(o);else{const z=t.items.find(R=>R.key===B);if(z){if(!z.quantityChange){ie({status:!0,message:"itemQuantityDisabled"});return}const R=[...t.items],Le=R.findIndex(be=>be.key===B);R[Le].quantity+=1,i({...t,items:R})}else L(Q.key,Q.label,Q.price,Q.quantity,Q.priceChange,Q.quantityChange)}},C=o=>{const B=T==null?void 0:T.find(Q=>Q.key===o);return(B==null?void 0:B.price)??""},M=()=>{const o=n==null?void 0:n.create;return!!(o!=null&&o.includes("__personal"))},ke=()=>{const o=n==null?void 0:n.create,B=Z==null?void 0:Z.grade.level;return!!(o!=null&&o.includes("-1")||B&&(o!=null&&o.includes(B)))};return e.jsxs(oa,{children:[e.jsx("div",{className:"tgg-invoice-header",children:e.jsx("div",{className:"tgg-invoice-subtitle",children:b===D.Personal?r("invoice.personalInovice"):Z==null?void 0:Z.label})}),e.jsxs("div",{className:"tgg-invoice-body",children:[e.jsxs("div",{className:"tgg-invoice-row",children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.status"),":"]}),e.jsx("div",{className:"tgg-invoice-value",children:r("invoice.draftStatus")})]}),e.jsxs("div",{className:"tgg-invoice-row",children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.date"),":"]}),e.jsx("div",{className:"tgg-invoice-value",children:fe()})]}),e.jsxs("div",{className:"tgg-invoice-row",children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.from"),":"]}),e.jsx("div",{className:"tgg-invoice-value",children:S==null?void 0:S.fullName})]}),e.jsxs("div",{className:"tgg-invoice-row",children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.to"),":"]}),e.jsx("div",{className:"tgg-invoice-value",children:e.jsx(Pe,{className:"tgg-select",showSearch:!0,size:"small",variant:"borderless",style:{width:200},placeholder:r("invoice.selectRecipient"),optionFilterProp:"children",value:(t==null?void 0:t.recipientId)==""?null:t==null?void 0:t.recipientId,filterOption:(o,B)=>{var Q;return(Q=((B==null?void 0:B.label)??"").toLowerCase())==null?void 0:Q.includes(o.toLowerCase())},filterSort:(o,B)=>((o==null?void 0:o.label)??"").toLowerCase().localeCompare(((B==null?void 0:B.label)??"").toLowerCase()),onSelect:o=>F(o),options:w&&w.map(o=>({value:o.citizenId,label:A.showFullName?o.name:o.id.toString()}))})})]}),e.jsxs("div",{className:"tgg-invoice-row",children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.items"),":"]}),e.jsx("div",{className:"tgg-invoice-value"})]}),e.jsxs("div",{className:"tgg-items-container",ref:c,children:[(Fe=t==null?void 0:t.items)==null?void 0:Fe.map((o,B)=>{var Q;return e.jsx("div",{className:"tgg-item",children:e.jsxs(qe.Compact,{children:[((Q=t==null?void 0:t.items)==null?void 0:Q.length)>1&&e.jsx("div",{className:"tgg-remove-item-btn",onClick:()=>H(B),children:e.jsx(nt,{})}),e.jsx(Pe,{showSearch:!0,size:"small",filterOption:(z,R)=>((R==null?void 0:R.label)??"").includes(z),dropdownStyle:{width:250},onSelect:z=>W(z,B),style:{width:"50%",minWidth:"50%"},value:o.key,optionRender:z=>{var R;return e.jsx("div",{children:`${z.label} - ${ee(C(((R=z==null?void 0:z.value)==null?void 0:R.toString())??""),oe)}`})},options:T==null?void 0:T.map(z=>({value:z.key,label:z.label}))}),e.jsx(Ie,{size:"small",min:1,maxLength:5,addonAfter:"x",disabled:!o.quantityChange,value:o==null?void 0:o.quantity,onChange:z=>m(z??1,B),style:{minWidth:"15%"},controls:!1}),e.jsx(Ie,{size:"small",min:-1,maxLength:16,addonAfter:pe,disabled:!o.priceChange,value:o==null?void 0:o.price,onChange:z=>ue(z??-1,B),style:{minWidth:"25%"},controls:!1})]})},o.key+B)}),e.jsx("div",{className:"tgg-item",children:e.jsxs(qe.Compact,{children:[e.jsx("div",{id:"newItemBtn",className:"tgg-add-item-btn",children:e.jsx(Te,{})}),e.jsx(Pe,{showSearch:!0,size:"small",onSelect:o=>le(o),value:s,dropdownStyle:{width:250},style:{width:"50%",minWidth:"50%"},options:T==null?void 0:T.map(o=>({value:o.key,label:`${o.label}`})),optionRender:o=>e.jsx("div",{children:`${o.label} - ${ee(C(o.key.toString()),oe)}`}),onDropdownVisibleChange:o=>y(o),open:j,dropdownRender:o=>e.jsxs(e.Fragment,{children:[(X||b===D.Personal)&&e.jsxs(e.Fragment,{children:[e.jsxs(qe,{style:{padding:"0 8px 4px"},children:[e.jsx(rt,{variant:"borderless",placeholder:r("invoice.enterItem"),value:s==null?void 0:s.key,onChange:B=>{g({key:B.target.value,label:B.target.value,quantity:1,price:-1,priceChange:!0,quantityChange:!0})},onKeyDown:B=>B.stopPropagation()}),e.jsx(Ye,{disabled:!(s!=null&&s.key),type:"dashed",icon:e.jsx(Te,{}),onClick:()=>{y(!1),L()}})]}),e.jsx(ot,{style:{margin:"8px 0"}})]}),o]})}),e.jsx(Ie,{size:"small",min:1,maxLength:5,addonAfter:"x",value:s==null?void 0:s.quantity,onChange:o=>{!o||!(s!=null&&s.price)||g({price:(s==null?void 0:s.price)*o,quantity:o,label:(s==null?void 0:s.label)??"",key:(s==null?void 0:s.key)??"",priceChange:(s==null?void 0:s.priceChange)||!1})},style:{minWidth:"15%"},controls:!1}),e.jsx(Ie,{size:"small",min:-1,maxLength:16,addonAfter:pe,value:s==null?void 0:s.price,onChange:o=>{o&&g({price:o,label:(s==null?void 0:s.label)??"",key:(s==null?void 0:s.key)??"",quantity:(s==null?void 0:s.quantity)??1,priceChange:(s==null?void 0:s.priceChange)||!1})},style:{minWidth:"25%"},controls:!1})]})})]}),e.jsxs("div",{className:"tgg-invoice-row tgg-summary",children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.notes"),":"]}),e.jsx(lt,{className:"tgg-notes-input",count:{show:!0,max:70},value:t==null?void 0:t.notes,onChange:o=>{i({...t,notes:o.target.value})},variant:"borderless",rows:2,placeholder:r("invoice.notesPlaceholder"),maxLength:70})]}),e.jsx("div",{className:"tgg-divider-dashed"}),l&&l>0&&e.jsxs(e.Fragment,{children:[e.jsxs("div",{className:"tgg-invoice-row tgg-lighter",children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.subTotal"),":"]}),e.jsx("div",{className:"tgg-invoice-value",children:ee(ne(d),oe)})]}),e.jsxs("div",{className:"tgg-invoice-row tgg-lighter",children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.vat"),"(",l,"%):"]}),e.jsx("div",{className:"tgg-invoice-value",children:ee(ne(I),oe)})]})]}),e.jsxs("div",{className:"tgg-invoice-row",children:[e.jsxs("div",{className:"tgg-invoice-label",children:[r("invoice.total"),":"]}),e.jsx("div",{className:"tgg-invoice-value",children:ee(ne(x),oe)})]})]})]})},ca=V.div.attrs({className:"tgg-create-invoice-container"})`
	position: absolute;

	height: 100%;
	width: 100%;

	z-index: -1;

	${({open:t})=>t==re.Open||t==re.Closing?"z-index: 10;":"z-index: -1;"}

	.tgg-create-invoice {
		height: 100%;
		width: 100%;

		backdrop-filter: blur(6px);

		background-color: rgba(0, 0, 0, 0.2);
		box-shadow: inset 0 0 200px 1px ${Ce.insetShadow};

		transition:
			visibility 0s,
			opacity 0.25s linear;

		visibility: hidden;
		opacity: 0;

		overflow: hidden;
		border-radius: 25px;

		${({open:t})=>t==re.Open&&`
			visibility: visible;
			opacity: 1;
		`}

		${({open:t})=>t==re.Closing&&`
			visibility: visible;
			opacity: 0;
		`}
	}

	.tgg-create-invoice-body {
		display: flex;

		justify-content: center;

		gap: 2em;

		width: 100%;
		height: 100%;

		overflow: hidden;

		padding: 0 5em;

		.tgg-left-section,
		.tgg-middle-section,
		.tgg-right-section {
			display: flex;

			row-gap: 1em;

			padding: 2.5em 0;

			flex-direction: column;

			justify-content: start;

			width: 20%;
		}

		.tgg-middle-section {
			position: relative;

			width: fit-content;

			height: 100%;

			.tgg-create-invoice-container {
				display: flex;
				justify-content: center;
				align-items: center;

				position: relative;

				height: 100%;
				width: 100%;
			}
		}
	}
`,da=()=>{const{t}=te(),i=f.useRef(null),[r,c]=f.useState(0),s=v(n=>n.companyConfig),g=v(n=>n.playerData),j=v(n=>n.menuType),y=v(n=>n.jobInfo),[d,N]=f.useState({items:[],notes:"",recipientId:"",recipientName:"",sender:j==D.Personal?"__personal":(y==null?void 0:y.name)??"",senderId:(g==null?void 0:g.identifier)??"",senderName:(g==null?void 0:g.fullName)??"",taxPercentage:(s==null?void 0:s.taxPercentage)??0,total:0}),x=v(n=>n.filters),_=v(n=>n.createInvoiceModalOpen),I=q(n=>n.setCustomModal);q(n=>n.setMenuType);const u=q(n=>n.setFilters),l=q(n=>n.setCreateInvoiceModalOpen),$=q(n=>n.setFlexOasisData);f.useEffect(()=>{_==re.Closing?setTimeout(()=>{l(re.Closed)},250):_==re.Open&&N({items:[],notes:"",recipientId:"",recipientName:"",sender:j==D.Personal?"__personal":(y==null?void 0:y.name)??"",senderId:(g==null?void 0:g.identifier)??"",senderName:(g==null?void 0:g.fullName)??"",taxPercentage:(s==null?void 0:s.taxPercentage)??0,total:0})},[_]),f.useLayoutEffect(()=>{var n;i.current&&c((n=i.current)==null?void 0:n.offsetHeight)},[]);const w=()=>{const n={...d};n.items=n.items.filter(S=>S.price!==-1),N(n),I(null)},k=()=>d.items.some(n=>n.price===-1),A=()=>{if(k()){I({visible:!0,onOk:()=>w(),onCancel:()=>I(null),bodyText:t("invoice.hasDirtyItems")});return}d.sender!=="__personal"&&(d.senderCompanyName=y==null?void 0:y.label),G("billing:invoice:create",d,void 0,Me[69]).then(S=>{let b="";if(S!=null&&S.id){const Z={...x,society:"byMe",status:h.Unpaid,orderBy:ye.Newest,dateRange:{dateFrom:"",dateTo:""}};S.sender===Y.Personal?u({...Z,type:Y.Personal}):u({...Z,type:Y.Society}),l(re.Closing),b="invoiceCreated"}else b="invoiceCreateFailed";$({status:!0,message:b})})};return e.jsx(ca,{$middleSectionHeight:r,open:_,children:e.jsx("div",{className:"tgg-create-invoice",children:e.jsxs("div",{className:"tgg-create-invoice-body",children:[e.jsx("div",{className:"tgg-left-section"}),e.jsx("div",{className:"tgg-middle-section",children:e.jsx("div",{className:"tgg-create-invoice-container",ref:i,children:e.jsx(Se,{type:O.Create,body:e.jsx(la,{invoiceDetails:d,setInvoiceDetails:N}),footer:e.jsx(Kt,{handleCancelInvoice:()=>l(re.Closing),invoiceDetails:d,handleCreateInvoice:A})})})}),e.jsx("div",{className:"tgg-right-section"})]})})})},pa=V.div.attrs({className:"tgg-statistics-container"})`
	position: absolute;

	height: 100%;
	width: 100%;

	${({$open:t})=>t==de.Open||t==de.Closing?"z-index: 10;":"z-index: -1;"}

	.tgg-statistics {
		position: relative;

		height: 100%;
		width: 100%;

		backdrop-filter: blur(10px);

		background-color: rgb(15, 19, 39, 0.75);
		/* background-color: white; */
		box-shadow: inset 0 0 200px 1px ${Ce.insetShadow};

		transition:
			visibility 0s,
			opacity 0.25s linear;

		visibility: hidden;
		opacity: 0;

		overflow: hidden;
		border-radius: 25px;

		${({$open:t})=>t==de.Open&&`
			visibility: visible;
			opacity: 1;
		`}

		${({$open:t})=>t==de.Closing&&`
			visibility: visible;
			opacity: 0;
		`}

        .tgg-close-btn {
			position: absolute;

			top: 0.5em;
			right: 1em;

			background-color: transparent;
			border: none;

			font-size: 1.5em;

			width: 1em;
			height: 1em;

			svg {
				transition: opacity 0.25s ease-in-out;

				color: ${a.main.primaryColor};

				width: 100%;
				height: 100%;
			}

			&:hover {
				cursor: pointer;

				svg {
					opacity: 0.75;
				}
			}
		}

		.tgg-statistics-grid {
			display: flex;
			flex-direction: column;

			gap: 3em;

			padding: 4.5em 7.5em 2em 7.5em;

			.tgg-header-row {
				display: flex;
				align-items: center;

				.tgg-switch-btn-col {
					display: flex;
					justify-content: flex-end;
				}

				.tgg-title {
					font-size: 1.5em;
					font-weight: 600;
					color: ${a.main.primaryTextColor};
					opacity: 0.75;
				}

				.tgg-switch-society-btn {
					background-color: ${a.main.secondaryBackground};
					border: none;

					font-size: 1em;
					font-weight: 600;
					color: ${a.main.primaryTextColor};

					padding: 0.75em 1em;
					border-radius: 10px;

					transition: color 0.25s ease-in-out;

					box-shadow: 0 0 1.5px 0.5px ${a.main.primaryColor};

					&:hover {
						cursor: pointer;
						color: ${a.main.primaryColor};
					}
				}
			}
		}
	}

	.tgg-chart-container {
		position: relative;

		background-color: rgba(77, 77, 77, 0.05);
		backdrop-filter: blur(15px);

		border-radius: 17.5px;

		padding: 2em 1.5em;

		overflow: hidden;

		border-left: 1px solid rgba(80, 80, 80, 0.35);
		border-right: 1px solid rgba(80, 80, 80, 0.35);

		box-shadow: 0 0 2.5px 0.5px ${Ce.insetShadow};

		height: 370px;

		.tgg-chart-title {
			font-size: 1.25em;
			font-weight: 600;
			color: ${a.main.primaryTextColor};
			opacity: 0.75;
		}

		.tgg-addon-top,
		.tgg-addon-bottom {
			position: absolute;

			left: 50%;
			right: 50%;
			transform: translateX(-50%);

			width: 70%;
			height: 1px;

			background: linear-gradient(
				90deg,
				rgba(255, 255, 255, 0) 0%,
				${a.main.primaryColor},
				rgba(255, 255, 255, 0) 100%
			);
		}

		.tgg-addon-top {
			top: 0;
		}

		.tgg-addon-bottom {
			bottom: 0;
		}
	}

	.tgg-recent-payments {
		position: relative;

		background-color: rgba(77, 77, 77, 0.05);
		backdrop-filter: blur(15px);

		border-radius: 17.5px;

		padding: 2em 1.5em;

		overflow: hidden;

		border-left: 1px solid rgba(80, 80, 80, 0.35);
		border-right: 1px solid rgba(80, 80, 80, 0.35);

		box-shadow: 0 0 2.5px 0.5px ${Ce.insetShadow};

		height: 370px;

		.tgg-addon-top,
		.tgg-addon-bottom {
			position: absolute;

			left: 50%;
			right: 50%;
			transform: translateX(-50%);

			width: 70%;
			height: 1px;

			background: linear-gradient(
				90deg,
				rgba(255, 255, 255, 0) 0%,
				${a.main.primaryColor},
				rgba(255, 255, 255, 0) 100%
			);
		}

		.tgg-addon-top {
			top: 0;
		}

		.tgg-addon-bottom {
			bottom: 0;
		}

		.tgg-title {
			font-size: 1.25em;
			font-weight: 600;
			color: ${a.main.primaryTextColor};
			opacity: 0.75;
		}

		.tgg-payments-container {
			display: flex;
			flex-direction: column;
			gap: 0.5em;

			overflow-y: auto;
			overflow-x: hidden;

			margin-top: 0.25em;

			height: 300px;

			.tgg-no-recent-pay {
				display: flex;
				justify-content: center;
				align-items: center;

				font-size: 1.15em;
				font-weight: 600;
				color: ${a.main.primaryTextColor};

				opacity: 0.5;

				height: 100%;
				width: 100%;
			}

			&::-webkit-scrollbar {
				width: 3px;
				height: 3px;

				background-clip: padding-box;
				padding: 1em 0;
			}

			&::-webkit-scrollbar-button {
				width: 0px;
				height: 0px;
			}

			&::-webkit-scrollbar-thumb {
				background: ${p.p700};
				border: 0px none ${p.p700};
				border-radius: 50px;
			}

			&::-webkit-scrollbar-thumb:hover {
				background: ${p.p800};
			}

			&::-webkit-scrollbar-thumb:active {
				background: ${p.p700};
			}

			&::-webkit-scrollbar-track {
				background: ${a.main.primaryColor};
				border: 0px none ${a.main.primaryColor};

				border-radius: 50px;
			}

			&::-webkit-scrollbar-track:hover {
				background: ${a.main.primaryColor};
			}

			&::-webkit-scrollbar-track:active {
				background: ${a.main.primaryColor};
			}

			&::-webkit-scrollbar-corner {
				background: transparent;
			}

			.tgg-payment {
				display: flex;
				justify-content: space-between;

				padding: 0.5em 0;

				padding-right: 1em;

				.tgg-payment-header {
					display: flex;
					flex-direction: column;

					gap: 0.25em;

					.tgg-payment-title {
						font-size: 1em;
						font-weight: 600;
						color: ${a.main.primaryTextColor};
					}

					.tgg-payment-date {
						font-size: 0.85em;
						font-weight: 600;
						color: ${a.main.secondaryTextColor};
						opacity: 0.75;
					}
				}

				.tgg-payment-amount {
					display: flex;
					align-items: center;

					font-size: 1em;
					font-weight: 600;
					color: ${a.main.primaryTextColor};
				}

				.tgg-view-btn {
					background-color: transparent;
					border: none;

					font-size: 1em;
					font-weight: 600;
					color: ${a.main.primaryColor};

					padding: 0.5em 1em;
					border-radius: 10px;

					transition: all 0.25s ease-in-out;

					&:hover {
						cursor: pointer;
						color: #fff;
						box-shadow: 0 0 2.5px 0 ${a.main.primaryColor};
					}
				}
			}
		}
	}

	.tgg-info-header-row {
		display: flex;
		justify-content: space-between;

		row-gap: 1em;

		.tgg-info-card {
			position: relative;

			display: flex;
			align-items: center;

			width: 100%;
			height: 120px;

			background-color: rgba(77, 77, 77, 0.05);
			backdrop-filter: blur(15px);

			border-radius: 17.5px;

			padding: 2em 1.5em;

			border-left: 1px solid rgba(80, 80, 80, 0.35);
			border-right: 1px solid rgba(80, 80, 80, 0.35);

			box-shadow: 0 0 2.5px 0.5px ${Ce.insetShadow};

			.tgg-addon-top,
			.tgg-addon-bottom {
				position: absolute;

				left: 50%;
				right: 50%;
				transform: translateX(-50%);

				width: 70%;
				height: 1px;

				background: linear-gradient(
					90deg,
					rgba(255, 255, 255, 0) 0%,
					${a.main.primaryColor},
					rgba(255, 255, 255, 0) 100%
				);
			}

			.tgg-addon-top {
				top: 0;
			}

			.tgg-addon-bottom {
				bottom: 0;
			}

			.tgg-card-content {
				display: flex;

				width: 100%;

				gap: 2em;

				justify-content: start;

				.tgg-count {
					svg {
						font-size: 2em;
					}
				}

				.tgg-content {
					display: flex;
					flex-direction: column;

					gap: 0.25em;

					.tgg-value {
						font-size: 2em;
						font-weight: 600;
						color: ${a.main.primaryTextColor};
					}

					.tgg-label {
						font-size: 1em;
						font-weight: 600;
						color: ${a.main.secondaryTextColor};
						opacity: 0.65;
					}

					&.tgg-stats-content {
						flex-direction: row;

						justify-content: space-between;
						align-items: center;
						width: 100%;
					}
				}
			}
		}
	}

	.tgg-filters {
		display: flex;

		gap: 0.05em;

		.tgg-filter-btn {
			display: flex;
			justify-content: center;
			align-items: center;

			height: 2.15em;

			border-radius: 5px;

			overflow: hidden;

			padding: 0 1em;

			font-size: 1em;
			font-weight: 600;

			color: ${a.main.primaryTextColor};

			transition: color 0.25s ease-in-out;

			&:hover {
				cursor: pointer;
				color: ${a.main.primaryColor};
			}

			&.tgg-active {
				background-color: ${a.main.primaryColor};
				font-weight: 700;

				&:hover {
					box-shadow: 0 0 5px 0 ${a.main.primaryColor};
					color: #fff;
				}
			}
		}
	}

	.tgg-filters-wrapper {
		position: relative;

		.tgg-dropdown-filters {
			display: flex;
			justify-content: center;
			align-items: center;

			height: 30px;
			aspect-ratio: 1/1;

			background-color: transparent;
			border: none;
			outline: none;

			font-size: 1em;
			font-weight: 600;

			color: ${a.main.primaryTextColor};

			border-radius: 10px;

			box-shadow: 0 0 1.5px 0.5px ${a.main.primaryColor};

			opacity: 0.5;

			svg {
				font-size: 1.25em;
			}

			transition: all 0.25s ease-in-out;
			&:hover {
				opacity: 0.75;
				cursor: pointer;
				color: ${a.main.primaryColor};
			}

			&.tgg-filters-open {
				opacity: 1;
				border-bottom-left-radius: 0;
				border-bottom-right-radius: 0;
			}
		}

		.tgg-type-filters {
			position: absolute;

			z-index: 1;

			top: 30px;
			right: 0;

			display: flex;
			flex-direction: column;

			padding: 0.5em 1em;

			height: 0;
			width: 100px;

			opacity: 0;

			transition: all 0.25s ease-in-out;

			background-color: ${a.main.secondaryBackground};

			border-top-left-radius: 10px;
			border-bottom-right-radius: 10px;
			border-bottom-right-radius: 10px;

			box-shadow: 0 0 2.5px 0 ${a.main.primaryColor};

			&.tgg-open {
				height: 115px;
				opacity: 1;
			}

			.tgg-filter {
				display: flex;
				justify-content: start;
				align-items: center;

				height: 2em;

				font-size: 0.95em;
				font-weight: 600;

				color: ${a.main.primaryTextColor};

				transition: color 0.25s ease-in-out;

				&:hover {
					cursor: pointer;
					color: ${a.main.primaryColor};
				}

				&.tgg-active {
					color: ${a.main.primaryColor};
					font-weight: 700;

					&:hover {
						opacity: 0.75;
					}
				}
			}
		}
	}
`,ga=()=>{const{t}=te(),[i,r]=f.useState(0),[c,s]=f.useState(0),[g,j]=f.useState(0),[y,d]=f.useState([]),[N,x]=f.useState([]),[_,I]=f.useState("__personal"),[u,l]=f.useState({sender:"",period:"month",status:h.All}),[$,w]=f.useState(!0),[k,A]=f.useState(!1),n=v(C=>C.statisticsOpen),S=v(C=>C.settingsConfig),b=v(C=>C.companyConfig),Z=v(C=>C.playerData),U=v(C=>C.jobInfo),T=S.currencyFormat,X=S.dateTimeFormat,pe=U==null?void 0:U.label,oe=q(C=>C.setViewInvoice),he=q(C=>C.setViewInvoiceModalOpen),ge=q(C=>C.setStatisticsOpen);f.useEffect(()=>{if(n===de.Closing)setTimeout(()=>{ge(de.Closed)},250);else if(n===de.Open){const C={sender:"",period:"month",status:h.All};H()?C.sender=(b==null?void 0:b.jobIdentifier)??"__personal":(C.sender="__personal",C.senderId=(Z==null?void 0:Z.identifier)??""),I(C.sender),l(C),ie(C)}},[n]);const ae=C=>{G("billing:invoice:refresh-statistics",C??u,void 0,Ee).then(M=>{M&&(r(M.totalInvoices),s(M.totalIncome),j(M.totalExpectedIncome))})},ie=C=>{w(!0),G("billing:invoice:statistics",C??u,void 0,Ee).then(M=>{M&&(r(M.totalInvoices),s(M.totalIncome),j(M.totalExpectedIncome),d([...M.graphData].reverse()),x(M.recentPayments)),w(!1)})},me=()=>{ge(de.Closing)},fe=C=>ee(ne(+C),T),L=()=>{const C=b==null?void 0:b.create;return!!(C!=null&&C.includes("__personal"))},H=()=>{const C=b==null?void 0:b.create,M=U==null?void 0:U.grade.level;return!!(C!=null&&C.includes("-1")||M&&(C!=null&&C.includes(M)))},W=()=>{const C={sender:"",period:"month",status:h.All};_==="__personal"?(I((b==null?void 0:b.jobIdentifier)??"__personal"),C.sender=(b==null?void 0:b.jobIdentifier)??"__personal"):(I("__personal"),C.sender="__personal",C.senderId=(Z==null?void 0:Z.identifier)??""),l(C),ie(C)},ue=C=>{G("billing:invoice:count",C,void 0,0).then(M=>{r(M)})},m=C=>{const M={...u,period:C};l(M),ae(M)},F=C=>{const M={...u,status:C};l(M),ue(M),A(!1)},le=C=>{oe(C),he(J.Open)};return e.jsx(pa,{$open:n,children:e.jsxs("div",{className:"tgg-statistics",children:[e.jsx("button",{className:"tgg-close-btn",onClick:me,children:e.jsx(Ue,{})}),e.jsxs("div",{className:"tgg-statistics-grid",children:[e.jsxs(je,{className:"tgg-header-row",children:[e.jsx(K,{span:12,children:_==="__personal"?e.jsx("div",{className:"tgg-title",children:t("statistics.personalTitle")}):e.jsxs("div",{className:"tgg-title",children:[pe," ",t("statistics.statisticsLabel")]})}),e.jsx(K,{span:12,className:"tgg-switch-btn-col",children:H()&&L()&&e.jsxs("button",{className:"tgg-switch-society-btn",onClick:W,children:[t("statistics.switchTo"),_==="__personal"?pe:t("statistics.personalLabel")]})})]}),e.jsxs(je,{className:"tgg-info-header-row",gutter:25,style:{zIndex:2},children:[e.jsx(K,{span:24,children:e.jsxs("div",{className:"tgg-filters",children:[e.jsx("div",{onClick:()=>m("today"),className:`tgg-filter-btn ${(u==null?void 0:u.period)==="today"?" tgg-active":""}`,children:t("statistics.today")}),e.jsx("div",{onClick:()=>m("last_week"),className:`tgg-filter-btn ${(u==null?void 0:u.period)==="last_week"?" tgg-active":""}`,children:t("statistics.lastWeek")}),e.jsx("div",{onClick:()=>m("month"),className:`tgg-filter-btn ${(u==null?void 0:u.period)==="month"?" tgg-active":""}`,children:t("statistics.lastMonth")}),e.jsx("div",{onClick:()=>m("year"),className:`tgg-filter-btn ${(u==null?void 0:u.period)==="year"?" tgg-active":""}`,children:t("statistics.lastYear")})]})}),e.jsx(K,{span:8,children:e.jsxs("div",{className:"tgg-info-card",children:[e.jsx("div",{className:"tgg-addon-top"}),e.jsx("div",{className:"tgg-addon-bottom"}),e.jsxs("div",{className:"tgg-card-content",children:[e.jsx("div",{className:"tgg-icon tgg-count",children:e.jsx(Ut,{})}),e.jsxs("div",{className:"tgg-content tgg-stats-content",children:[e.jsxs("div",{className:"tgg-stats",children:[e.jsx("div",{className:"tgg-value",children:i}),e.jsxs("div",{className:"tgg-label",children:[u.status===h.All&&t("statistics.totalInvoices"),u.status===h.Paid&&t("statistics.totalPaid"),u.status===h.Unpaid&&t("statistics.totalUnpaid"),u.status===h.Cancelled&&t("statistics.totalCancelled")]})]}),e.jsxs("div",{className:"tgg-filters-wrapper",children:[e.jsx("button",{className:`tgg-dropdown-filters ${k?" tgg-filters-open":""}`,onClick:()=>A(!k),children:e.jsx(De,{})}),k&&e.jsxs("div",{className:`tgg-type-filters ${k?" tgg-open":""}`,children:[e.jsx("div",{onClick:()=>F(h.All),className:`tgg-filter ${u.status===h.All?" tgg-active":""}`,children:t("statistics.all")}),e.jsx("div",{onClick:()=>F(h.Paid),className:`tgg-filter ${u.status===h.Paid?" tgg-active":""}`,children:t("statistics.paid")}),e.jsx("div",{onClick:()=>F(h.Unpaid),className:`tgg-filter ${u.status===h.Unpaid?" tgg-active":""}`,children:t("statistics.unpaid")}),e.jsx("div",{onClick:()=>F(h.Cancelled),className:`tgg-filter ${u.status===h.Cancelled?" tgg-active":""}`,children:t("statistics.cancelled")})]})]})]})]})]})}),e.jsx(K,{span:8,children:e.jsxs("div",{className:"tgg-info-card",children:[e.jsx("div",{className:"tgg-addon-top"}),e.jsx("div",{className:"tgg-addon-bottom"}),e.jsxs("div",{className:"tgg-card-content",children:[e.jsx("div",{className:"tgg-icon",children:e.jsx(Jt,{})}),e.jsxs("div",{className:"tgg-content",children:[e.jsx("div",{className:"tgg-value",children:ee(ne(c),T)}),e.jsx("div",{className:"tgg-label",children:t("statistics.totalIncome")})]})]})]})}),e.jsx(K,{span:8,children:e.jsxs("div",{className:"tgg-info-card",children:[e.jsx("div",{className:"tgg-addon-top"}),e.jsx("div",{className:"tgg-addon-bottom"}),e.jsxs("div",{className:"tgg-card-content",children:[e.jsx("div",{className:"tgg-icon",children:e.jsx(Dt,{})}),e.jsxs("div",{className:"tgg-content",children:[e.jsx("div",{className:"tgg-value",children:ee(ne(g),T)}),e.jsx("div",{className:"tgg-label",children:t("statistics.totalUnpaidExp")})]})]})]})})]}),e.jsxs(je,{justify:"space-between",gutter:25,style:{zIndex:1},children:[e.jsx(K,{span:16,children:e.jsxs("div",{className:"tgg-chart-container",children:[e.jsx("div",{className:"tgg-chart-title",children:t("statistics.incomeOverview")}),e.jsx("div",{className:"tgg-addon-top"}),e.jsx("div",{className:"tgg-addon-bottom"}),e.jsxs(ct,{width:$?0:800,height:300,data:y,margin:{top:50,right:30,left:25,bottom:50},children:[e.jsx("defs",{children:e.jsxs("linearGradient",{id:"colorPv",x1:"0",y1:"0",x2:"0",y2:"1",children:[e.jsx("stop",{offset:"5%",stopColor:a.main.primaryColor,stopOpacity:.8}),e.jsx("stop",{offset:"95%",stopColor:a.main.primaryColor,stopOpacity:0})]})}),e.jsx(dt,{dataKey:"date",angle:-50,textAnchor:"end",fontSize:12,stroke:"rgba(255, 255, 255, 0.75)"}),e.jsx(pt,{tickFormatter:fe,fontSize:12,stroke:"rgba(255, 255, 255, 0.75)"}),e.jsx(gt,{vertical:!1,stroke:"rgba(255, 255, 255, 0.15)"}),e.jsx(mt,{dot:{fill:"#fff",stroke:a.main.primaryColor,strokeWidth:2},height:300,type:"monotone",dataKey:"total",stroke:a.main.primaryColor,fillOpacity:1,fill:"url(#colorPv)"}),e.jsx(ut,{animationDuration:0,formatter:C=>[ee(ne(+C),T),t("statistics.income")]})]})]})}),e.jsx(K,{span:8,children:e.jsxs("div",{className:"tgg-recent-payments",children:[e.jsx("div",{className:"tgg-addon-top"}),e.jsx("div",{className:"tgg-addon-bottom"}),e.jsx("div",{className:"tgg-title",children:t("statistics.recentPayments")}),e.jsxs("div",{className:"tgg-payments-container",children:[N.length===0&&e.jsx("div",{className:"tgg-no-recent-pay",children:t("statistics.emptyRecentPayments")}),N.map((C,M)=>e.jsxs("div",{className:"tgg-payment",children:[e.jsxs("div",{className:"tgg-payment-header",children:[e.jsx("div",{className:"tgg-payment-title",children:C.recipientName}),e.jsx("div",{className:"tgg-payment-date",children:Je(C.lastModified??0,X)})]}),e.jsx("div",{className:"tgg-payment-amount",children:ee(ne(C.total+C.total*(C.taxPercentage/100)),T)}),e.jsx("button",{className:"tgg-view-btn",onClick:()=>le(C),children:t("statistics.view")})]},M))]})]})})]})]})]})})},ma=V.div.attrs({className:"tgg-view-invoice-container"})`
	position: absolute;

	height: 100%;
	width: 100%;

	${({$open:t})=>t==J.Open||t==J.Closing?"z-index: 10;":"z-index: -1;"}

	.tgg-view-invoice {
		height: 100%;
		width: 100%;

		backdrop-filter: blur(6px);

		background-color: rgba(0, 0, 0, 0.2);
		box-shadow: inset 0 0 200px 1px ${Ce.insetShadow};

		transition:
			visibility 0s,
			opacity 0.25s linear;

		visibility: hidden;
		opacity: 0;

		overflow: hidden;
		border-radius: 25px;

		${({$open:t})=>t==J.Open&&`
			visibility: visible;
			opacity: 1;
		`}

		${({$open:t})=>t==J.Closing&&`
			visibility: visible;
			opacity: 0;
		`}
	}

	.tgg-create-invoice-body {
		display: flex;

		justify-content: center;

		gap: 2em;

		width: 100%;
		height: 100%;

		overflow: hidden;

		.tgg-left-section,
		.tgg-middle-section,
		.tgg-right-section {
			display: flex;

			row-gap: 1em;

			padding: 2.5em 0;

			flex-direction: column;

			justify-content: start;

			width: -webkit-fill-available;
		}

		.tgg-middle-section {
			position: relative;

			width: fit-content;

			height: 100%;

			${({$open:t})=>t==J.Open&&`
				.tgg-view-invoice-container {
					display: flex;
					justify-content: center;
					align-items: center;

					position: relative;

					height: 100%;
					width: 100%;
				}
			`}
		}

		.tgg-right-section {
			display: flex;

			align-items: end;

			.tgg-close-btn {
				background-color: transparent;
				border: none;

				font-size: 1.5em;

				width: 1em;
				height: 1em;

				margin-right: 2.25em;

				svg {
					transition: opacity 0.25s ease-in-out;

					color: ${a.main.primaryColor};

					width: 100%;
					height: 100%;
				}

				&:hover {
					cursor: pointer;

					svg {
						opacity: 0.75;
					}
				}
			}
		}
	}
`,ua=()=>{const t=f.useRef(null),[i,r]=f.useState(0),c=v(d=>d.viewInvoice),s=v(d=>d.viewInvoiceModalOpen),g=q(d=>d.setViewInvoiceModalOpen),j=q(d=>d.setViewInvoice);f.useEffect(()=>{s===J.Closing&&setTimeout(()=>{g(J.Closed)},250)},[s]),f.useLayoutEffect(()=>{var d;t.current&&r((d=t.current)==null?void 0:d.offsetHeight)},[]);const y=()=>{g(J.Closing),j(null)};return e.jsx(ma,{$middleSectionHeight:i,$open:s,children:e.jsx("div",{className:"tgg-view-invoice",children:e.jsxs("div",{className:"tgg-create-invoice-body",children:[e.jsx("div",{className:"tgg-left-section"}),e.jsx("div",{className:"tgg-middle-section",children:e.jsx("div",{className:"tgg-view-invoice-container",ref:t,children:c&&e.jsx(Se,{type:O.Details,body:e.jsx(Qe,{invoice:c,invoiceLocation:O.Details}),footer:e.jsx(ze,{invoice:c,invoiceLocation:O.Details})})})}),e.jsx("div",{className:"tgg-right-section",children:e.jsx("button",{className:"tgg-close-btn",onClick:y,children:e.jsx(Ue,{})})})]})})})},ha=V.div.attrs({className:"tgg-settings-drawer-container"})`
	.tgg-settings-drawer {
		border-right: 0.3em solid black;
		border-top: 0.3em solid black;
		border-bottom: 0.3em solid black;
		border-top-right-radius: 30px;
		border-bottom-right-radius: 30px;
		background-color: ${a.main.secondaryBackground};

		.ant-drawer-header {
			border-color: ${a.main.primaryColor};

			.ant-drawer-title {
				color: #fff;
			}

			.ant-drawer-close {
				color: #fff;
			}
		}
	}

	.tgg-scaling-slider-container {
		display: flex;
		align-items: center;

		gap: 1em;

		svg {
			font-size: 1.75em;
			color: ${a.main.primaryColor};
		}

		.ant-slider {
			width: 100%;

			.ant-slider-rail {
				background-color: ${a.main.primaryColor};
			}
		}
	}

	.tgg-label {
		color: #fff;
		font-size: 1.25em;
		font-weight: 600;
		margin-bottom: 0.25em;
	}
`,fa=()=>{const{t}=te(),i=v(x=>x.settingsDrawerOpen),r=v(x=>x.playerData),c=v(x=>x.resizeBy),s=r==null?void 0:r.identifier,g=q(x=>x.setResizeBy),j=q(x=>x.setSettingsDrawerOpen);f.useEffect(()=>{y()},[s]);const y=()=>{if(!s)return;const x=localStorage.getItem("billing-settings");let _=x?JSON.parse(x):{};_[s]||(_[s]={resizeBy:1},localStorage.setItem("billing-settings",JSON.stringify(_))),g(_[s].resizeBy)},d=x=>{if(!s)return;const _=localStorage.getItem("billing-settings");let I=_?JSON.parse(_):{};I[s]||(I[s]={}),I[s].resizeBy=x,localStorage.setItem("billing-settings",JSON.stringify(I))},N=x=>{isNaN(x)||(g(x),d(x))};return e.jsx(ha,{children:e.jsxs(ht,{title:"Settings",onClose:()=>j(!1),open:i,getContainer:()=>document.querySelector(".tgg-settings-drawer-container"),className:"tgg-settings-drawer",children:[e.jsx("div",{className:"tgg-label",children:t("general.scale")}),e.jsxs("div",{className:"tgg-scaling-slider-container",children:[e.jsx(ft,{}),e.jsx(bt,{onChange:N,step:.1,min:.9,max:1.3,value:typeof c=="number"?c:1})]})]})})},{RangePicker:ba}=xt,xa=V.div.attrs({className:"tgg-custom-range-picker-wrapper"})`
	.tgg-range-picker-input-wrapper {
		position: relative;

		width: 95%;
		height: 45px;

		overflow: hidden;

		z-index: 1;

		border-top-right-radius: 17.5px;
		border-bottom-right-radius: 17.5px;

		transition: border-radius 0.25s ease-in-out;
		${({$rangePickerOpen:t})=>t&&"border-top-right-radius: 0;"}

		box-shadow: 1.5px 0px 2.5px 1.5px
				${a.button.primaryFilterBorderColor};

		.tgg-custom-range-picker {
			width: 100%;
			height: 100%;

			background-color: ${a.main.secondaryBackground};

			border-top-right-radius: 17.5px;
			border-bottom-right-radius: 17.5px;

			transition: border-radius 0.25s ease-in-out;
			${({$rangePickerOpen:t})=>t&&"border-top-right-radius: 0;"}

			border-top-left-radius: 0;
			border-bottom-left-radius: 0;

			border-left: none;
			border: none;

			overflow: hidden;

			.ant-picker-input:first-child {
				input {					
					font-family: 'Poppins', sans-serif;

					text-align: center;
					color: ${a.main.primaryColor};
				}
			}

			.ant-picker-range-separator {
				height: 100%;

				.ant-picker-separator {
					display: flex;
					align-items: center;
					height: 100%;
				}

				svg {
					color: ${a.main.secondaryColor};
					font-size: 1.25em;
				}
			}

			.ant-picker-input {
				input {
					&::placeholder {
						font-size: 1.1em;
						color: ${a.main.primaryColor};
						font-family: 'Poppins', sans-serif;
					}

					font-size: 1em;
					font-family: 'Poppins', sans-serif;
					text-align: center;
					color: ${a.main.primaryColor} !important;

					&:hover {
						cursor: pointer;
					}
				}
			}

			.anticon-calendar {
				visibility: hidden;
			}

			.ant-picker-suffix,
			.ant-picker-clear {
				z-index: 2;

				svg {
					color: ${a.main.primaryColor};
				}
			}
		}

		.tgg-attachment {
			position: absolute;
			right: -2px;
			top: 50%;
			bottom: 50%;
			transform: translateY(-50%);

			height: 50%;
			width: 5px;

			background-color: ${a.main.primaryColor};
			filter: drop-shadow(-1px 0px 5px ${a.main.primaryColor});
		}

		.tgg-side-border {
			position: absolute;

			top: 0;

			height: 100%;
			width: 18px;

			transition: border-radius 0.25s ease-in-out;

			border-radius: 0 17.5px 17.5px 0;

			${({$rangePickerOpen:t})=>t&&"border-top-right-radius: 0;"}

			right: 0;

			border-top: 1px solid ${a.main.primaryColor};
			border-right: 1px solid ${a.main.primaryColor};
			border-bottom: 1px solid ${a.main.primaryColor};

			overflow: hidden;

			z-index: 0;
		}

		.tgg-border-top,
		.tgg-border-bottom {
			position: absolute;

			left: 0;

			height: 1px;
			width: 100%;

			background: linear-gradient(
				90deg,
				${a.main.primaryColor} 0%,
				rgba(22, 26, 32, 0) 90%
			);

			background: linear-gradient(
				90deg,
				rgba(22, 26, 32, 0) 0%,
				${a.main.primaryColor} 90%
			);

			z-index: 1;
		}

		.tgg-border-top {
			top: 0;
		}

		.tgg-border-bottom {
			bottom: 0;
		}
	}

	/* Range Picker Popup */
	.tgg-picker-dropdown-wrapper {
		position: absolute;

		z-index: 10;

		.ant-picker-ok button {
			background-color: ${a.main.primaryColor};
			color: ${a.main.primaryTextColor};
			border-radius: 7.5px;
			border: none;
			outline: none;

			&:hover:not(:disabled) {
				box-shadow: 0px 0px 2.5px 0.5px ${a.main.primaryColor};
			}
		}

		.ant-picker-dropdown {
			top: -407.5px !important;
			left: 0px !important;

			.ant-picker-range-arrow {
				display: none;

				&:before,
				&:after {
					background: ${a.main.secondaryBackground} !important;
					box-shadow: 0px 0px 2.5px 0.5px ${a.main.primaryColor} !important;
				}
			}

			.ant-picker-panel-container {
				background-color: ${a.main.secondaryBackground};
				box-shadow: 0px 0px 2.5px 0.5px ${a.main.primaryColor};

				border-top-left-radius: 0;
				border-bottom-left-radius: 0;

				border-top-right-radius: 17.5px;
				border-bottom-right-radius: 17.5px;

				.ant-picker-header {
					border-color: ${a.main.border};

					.ant-picker-header-view {
						color: ${a.main.primaryTextColor};
					}

					.ant-picker-header-super-prev-btn {
						.ant-picker-super-prev-icon:before,
						.ant-picker-super-prev-icon:after {
							color: ${a.main.primaryColor};
						}

						&:hover {
							.ant-picker-super-prev-icon:before,
							.ant-picker-super-prev-icon:after {
								color: ${a.main.secondaryColor};
							}
						}
					}

					.ant-picker-header-prev-btn {
						.ant-picker-prev-icon:before {
							color: ${a.main.primaryColor};
						}

						&:hover {
							.ant-picker-prev-icon:before {
								color: ${a.main.secondaryColor};
							}
						}
					}

					.ant-picker-header-super-next-btn {
						.ant-picker-super-next-icon:before,
						.ant-picker-super-next-icon:after {
							color: ${a.main.primaryColor};
						}

						&:hover {
							.ant-picker-super-next-icon:before,
							.ant-picker-super-next-icon:after {
								color: ${a.main.secondaryColor};
							}
						}
					}

					.ant-picker-header-next-btn {
						.ant-picker-next-icon:before {
							color: ${a.main.primaryColor};
						}
						&:hover {
							.ant-picker-next-icon:before {
								color: ${a.main.secondaryColor};
							}
						}
					}
				}

				thead tr th {
					color: ${a.main.secondaryTextColor};
				}

				.ant-picker-cell-inner {
					color: ${a.main.primaryTextColor};
				}
			}
		}
	}

	.ant-picker-cell-range-start,
	.ant-picker-cell-range-end {
		&:before {
			border-top: 1px solid ${p.p900};
			border-bottom: 1px solid ${p.p900};
			background: ${p.p950} !important;
		}
	}

	.ant-picker-cell-in-range {
		.ant-picker-cell-inner {
			background: transparent;
		}

		&:before {
			border-top: 1px solid ${p.p900};
			border-bottom: 1px solid ${p.p900};
			background: ${p.p950} !important;
		}
	}

	.ant-picker-presets {
		ul {
			/* font-size: 1.1em; */
			font-weight: 600;
			border-color: ${a.main.border} !important;

			li {
				position: relative;
				color: ${a.main.primaryTextColor};

				&:hover {
					color: ${a.main.secondaryTextColor};
				}

				&:before {
					content: '';
					position: absolute;

					left: 0;

					top: 50%;
					bottom: 50%;
					transform: translateY(-50%);

					width: 2px;
					height: 60%;

					background-color: ${a.main.primaryColor};
					box-shadow: 0px 0px 2.5px 0.5px ${a.main.primaryColor};
				}
			}
		}
	}
	/* Range Picker Popup */
`,ya=()=>{const{t}=te(),[i,r]=f.useState(!1),c=v(y=>y.settingsConfig),s=v(y=>y.filters);c.dateFormat;const g=q(y=>y.setFilters);se().add(-7,"d"),se(),se().add(-14,"d"),se(),se().add(-30,"d"),se(),se().add(-90,"d"),se();const j=y=>{var d,N;if(y){const x=(d=y[0])==null?void 0:d.format("YYYY-MM-DD"),_=(N=y[1])==null?void 0:N.format("YYYY-MM-DD");g({...s,dateRange:{dateFrom:x??"",dateTo:_??""}})}else g({...s,dateRange:{dateFrom:"",dateTo:""}})};return e.jsxs(xa,{$rangePickerOpen:i,children:[e.jsxs("div",{className:"tgg-range-picker-input-wrapper",children:[e.jsx("div",{className:"tgg-border-top"}),e.jsx("div",{className:"tgg-border-bottom"}),e.jsx(ba,{allowClear:!0,picker:"date",className:"tgg-custom-range-picker",onOpenChange:y=>r(y),placeholder:[t("filters.dateFrom"),t("filters.dateTo")],needConfirm:!0,onChange:y=>{y||j(y)},value:[s.dateRange.dateFrom==""?void 0:se(s.dateRange.dateFrom),s.dateRange.dateTo==""?void 0:se(s.dateRange.dateTo)],onOk:y=>j(y),inputReadOnly:!0,open:i,getPopupContainer:()=>document.getElementById("tgg-picker-dropdown-wrapper")}),e.jsx("div",{className:"tgg-attachment"}),e.jsx("div",{className:"tgg-side-border"})]}),e.jsx("div",{className:"tgg-picker-dropdown-wrapper",id:"tgg-picker-dropdown-wrapper"})]})},Ca=V.div.attrs({className:"tgg-info-filter"})`
	position: relative;

	display: flex;
	justify-content: start;
	align-items: center;

	background-color: ${a.main.secondaryBackground};

	user-select: none;

	.tgg-active-icon {
		position: absolute;

		right: 12.5px;

		svg {
			font-size: 1.25em;
			opacity: 0.55;
		}

		display: none;
	}

	${({$active:t})=>t?`

		.tgg-active-icon {
			display: flex;
		}

		&:before {
			content: '';
			position: absolute;

			left: 0;

			top: 50%;
			bottom: 50%;
			transform: translateY(-50%);

			height: 50%;
			width: 3px;

			background-color: ${a.button.secondaryFilterBorderColor};
			filter: drop-shadow(5px 5px 5px ${a.main.secondaryColor});
		}

		color: ${a.main.secondaryColor};
		box-shadow: 1.5px 0px 2.5px 1.5px ${a.button.secondaryFilterBorderColor};
		
		transition: box-shadow 0.25s ease-in-out;
		&:hover {
			cursor: pointer;
			box-shadow: 4.5px 0px 7.5px 4.5px ${a.button.secondaryFilterBorderColor};
		}
		`:`
		color: ${a.main.primaryColor};
		box-shadow: 1.5px 0px 2.5px 1.5px ${a.button.primaryFilterBorderColor};
		
		transition: box-shadow 0.25s ease-in-out;
		&:hover {
			cursor: pointer;

			box-shadow: 3.5px 0px 7.5px 3.5px ${a.button.primaryFilterBorderColor};
		}
	`};

	height: 45px;
	width: 95%;

	overflow: hidden;

	.tgg-label {
		line-height: 1em;
		font-size: 1em;

		padding-left: 1.25em;

		> span {
			font-weight: 600;
		}
	}

	.tgg-side-border {
		position: absolute;

		height: 100%;
		width: 20px;

		border-radius: 0 17.5px 17.5px 0;
	}

	${({$direction:t,$active:i})=>t==="left"?`
			border-top-right-radius: 17.5px;
			border-bottom-right-radius: 17.5px;

			.tgg-side-border {
				right: 0;

				border-top: 1px solid ${a.main.primaryColor};
				border-right: 1px solid ${a.main.primaryColor};
				border-bottom: 1px solid ${a.main.primaryColor};

				${i&&`border-color: ${a.main.secondaryColor};`};

				overflow: hidden;
			}

			.tgg-attachment {
				position: absolute;
				right: -2px;
				top: 50%;
				bottom: 50%;
				transform: translateY(-50%);

				height: 50%;
				width: 5px;

				background-color: ${a.main.primaryColor};
				filter: drop-shadow(-1px 0px 5px ${a.main.primaryColor});

				${i&&`
					background-color: ${a.main.secondaryColor};
					filter: drop-shadow(-1px 0px 5px ${a.main.secondaryColor});	
				`};
			}

			.tgg-border-top,
			.tgg-border-bottom {
				background: linear-gradient(
					90deg,
					rgba(22, 26, 32, 0) 0%,
					${a.main.primaryColor} 90%);

				${i&&`
					background: linear-gradient(
						90deg,
						rgba(22, 26, 32, 0) 0%,
						${a.main.secondaryColor} 90%);
				`};
			}
			`:`
			border-top-left-radius: 17.5px;
			border-bottom-left-radius: 17.5px;

			.tgg-side-border {
				left: 0;

				width: 20px;

				transform: rotate(180deg);

				border-top: 1px solid ${a.main.primaryColor};
				border-right: 1px solid ${a.main.primaryColor};
				border-bottom: 1px solid ${a.main.primaryColor};
			}

			.tgg-attachment {
				position: absolute;
				left: -2px;
				top: 50%;
				bottom: 50%;
				transform: translateY(-50%);

				height: 50%;
				width: 6px;

				background-color: ${a.main.primaryColor};
				filter: drop-shadow(-1px 0px 5px ${a.main.primaryColor});
			}

			.tgg-border-top,
			.tgg-border-bottom {
				background: linear-gradient(
					90deg, 
					${a.main.primaryColor} 0%,
					rgba(22, 26, 32, 0) 90%);
			}
	`}

	.tgg-border-top,
	.tgg-border-bottom {
		position: absolute;

		height: 1px;
		width: 100%;
	}

	.tgg-border-top {
		top: 0;
	}

	.tgg-border-bottom {
		bottom: 0;
	}
`,we=({label:t,active:i,onClick:r,direction:c="left"})=>{const s=()=>{const[g,j]=t.split("(");return j?e.jsxs(e.Fragment,{children:[g,e.jsxs("span",{children:["(",j]})]}):e.jsx(e.Fragment,{children:g})};return e.jsxs(Ca,{$direction:c,$active:i,onClick:r,children:[e.jsx("div",{className:"tgg-border-top"}),e.jsx("div",{className:"tgg-border-bottom"}),e.jsx("div",{className:"tgg-side-border"}),e.jsx("div",{className:"tgg-attachment"}),e.jsx("div",{className:"tgg-label",children:s()}),e.jsx("div",{className:"tgg-active-icon",children:e.jsx(yt,{})})]})},va=V.div.attrs({className:"tgg-sidebar"})`
	width: 15.5%;
	height: 100%;

	padding-right: 0.25em;
	padding-bottom: 30px;

	.tgg-filters-container {
		height: calc(100% - ${t=>t.$playerInfoContainerHeight}px);

		.tgg-invoices-filters-container {
			display: flex;

			flex-direction: column;

			gap: 1em;

			.tgg-separator {
				position: relative;

				display: flex;
				align-items: center;

				gap: 7.5px;

				width: 87.5%;

				margin-left: 0.75em;

				padding: 0.25em 0;

				user-select: none;

				.tgg-separator-line-1 {
					height: 1.5px;
					width: 25%;

					border-radius: 20px;

					background-color: ${a.main.primaryColor};
					box-shadow: 0px 0px 5px 0px ${a.main.primaryColor};
				}

				.tgg-label {
					color: ${a.main.primaryTextColor};
					font-size: 0.85em;
				}

				.tgg-separator-line-2 {
					height: 1.5px;
					width: 85%;

					border-radius: 20px;

					background-color: ${a.main.secondaryColor};
					box-shadow: 0px 0px 5px 0px ${a.main.secondaryColor};
				}
			}

			.tgg-personal-btn-wrapper {
				position: relative;

				height: 100%;
				width: 100%;

				.tgg-new-invoice-icon {
					position: absolute;

					top: -2.5px;
					right: 7.5px;

					height: 15px;
					width: 15px;

					border-radius: 50%;
					background-color: ${a.main.primaryColor};

					opacity: 0.85;

					box-shadow: 0px 0px 5px 0px ${a.main.primaryColor};

					z-index: 1;
				}
			}
		}
	}

	.tgg-player-info-container {
		position: relative;

		display: flex;
		gap: 0.5em;

		width: 90%;

		background-color: #0f1327;

		padding: 0.75em;

		border-radius: 20px;

		margin: 0 auto;

		overflow: hidden;

		box-shadow: 0px 0px 5px 0px rgba(30, 136, 229, 0.5);

		.tgg-border-top,
		.tgg-border-bottom {
			position: absolute;

			left: 50%;
			right: 50%;
			transform: translateX(-50%);
			width: 80%;

			height: 1px;

			background: linear-gradient(
				90deg,
				${P(p.p500,.75)} 0%,
				${P(p.p500,.25)} 30%,
				${P(p.background,1)} 50%,
				${P(p.p500,.25)} 70%,
				${P(p.p500,.75)} 100%
			);
		}

		.tgg-border-top {
			top: 0;
		}

		.tgg-border-bottom {
			bottom: 0;
		}

		.tgg-btn-addon-right,
		.tgg-btn-addon-left {
			position: absolute;
			top: 0;

			width: 20.5px;
			height: 100%;
		}

		.tgg-btn-addon-right {
			right: 0;

			border-top-right-radius: 20px;
			border-bottom-right-radius: 20px;

			border-left: 0;
			border-top: 1px solid ${a.main.border};
			border-bottom: 1px solid ${a.main.border};
			border-right: 2px solid ${a.main.border};
		}

		.tgg-btn-addon-left {
			left: 0;

			border-top-left-radius: 20px;
			border-bottom-left-radius: 20px;

			border-right: 0;
			border-top: 1px solid ${a.main.border};
			border-bottom: 1px solid ${a.main.border};
			border-left: 2px solid ${a.main.border};
		}

		.tgg-info-row {
			display: flex;
			align-items: center;

			width: 100%;

			overflow: hidden;

			.tgg-avatar {
				display: flex;
				justify-content: center;
				align-items: center;

				height: 3.25em;
				width: 3.25em;
				border-radius: 50%;

				overflow: hidden;

				img {
					height: 100%;
					width: 100%;
					object-fit: cover;
				}
			}

			.tgg-info {
				display: flex;
				flex-direction: column;

				justify-content: center;
				align-items: start;

				row-gap: 0.25em;

				color: #fff;

				overflow: hidden;

				.tgg-name {
					white-space: nowrap;
					text-overflow: ellipsis;
					overflow: hidden;

					width: 100%;

					font-size: 1.1em;
					font-weight: 600;
				}

				.tgg-money {
					white-space: nowrap;
					text-overflow: ellipsis;
					overflow: hidden;

					width: 100%;

					font-size: 0.95em;
					color: ${a.main.secondaryTextColor};
				}
			}
		}
	}
`,ka=()=>{var S;const{t}=te(),i=f.useRef(null),[r,c]=f.useState(0),[s,g]=f.useState(!1),j=v(b=>b.settingsConfig),y=v(b=>b.companyConfig),d=v(b=>b.totalInvoices),N=v(b=>b.hasNewInvoice),x=v(b=>b.playerData),_=v(b=>b.jobInfo),I=v(b=>b.filters),u=v(b=>b.mugshot),l=j.currencyFormat,$=q(b=>b.setFilters);q(b=>b.setMugshot);const w=q(b=>b.setHasNewInvoice);f.useLayoutEffect(()=>{var b;i.current&&c((b=i.current)==null?void 0:b.offsetHeight)},[]);const k=b=>{s||I.type===b||(b===Y.Personal&&N&&w(!1),$({...I,type:b}),g(!0),setTimeout(()=>{g(!1)},750))},A=b=>{s||I.status===b||($({...I,status:b}),g(!0),setTimeout(()=>{g(!1)},750))},n=()=>{var U;const b=y==null?void 0:y.create,Z=(U=_==null?void 0:_.grade)==null?void 0:U.level;return(y==null?void 0:y.jobIdentifier)=="other"?!1:!!(b&&b.length>0&&(b.includes("-1")||Z&&b.includes(Z)||b.includes(Y.Personal)))};return e.jsxs(va,{$playerInfoContainerHeight:r,children:[e.jsx("div",{className:"tgg-filters-container",children:e.jsxs("div",{className:"tgg-invoices-filters-container",id:"tgg-invoices-filters-container",children:[e.jsxs("div",{className:"tgg-separator",children:[e.jsx("div",{className:"tgg-separator-line-1"}),e.jsx("div",{className:"tgg-label",children:t("filters.filterType")}),e.jsx("div",{className:"tgg-separator-line-2"})]}),e.jsxs("div",{className:"tgg-personal-btn-wrapper",children:[N&&e.jsx("div",{className:"tgg-new-invoice-icon"}),e.jsx(we,{active:I.type===Y.Personal,label:t("filters.myInvoices"),onClick:()=>k(Y.Personal)})]}),n()&&e.jsx(we,{active:I.type===Y.Society,label:t("filters.societyInvoices"),onClick:()=>k(Y.Society)}),e.jsxs("div",{className:"tgg-separator",children:[e.jsx("div",{className:"tgg-separator-line-1"}),e.jsx("div",{className:"tgg-label",children:t("filters.filterStatus")}),e.jsx("div",{className:"tgg-separator-line-2"})]}),e.jsx(we,{active:I.status===h.All,label:`${t("filters.allInvoices")} ${I.status===h.All?`(${d})`:""}`,onClick:()=>A(h.All)}),e.jsx(we,{label:`${t("filters.paidInvoices")} ${I.status===h.Paid?`(${d})`:""}`,active:I.status===h.Paid,onClick:()=>A(h.Paid)}),e.jsx(we,{label:`${t("filters.unpaidInvoices")} ${I.status===h.Unpaid?`(${d})`:""}`,active:I.status===h.Unpaid,onClick:()=>A(h.Unpaid)}),e.jsx(we,{label:`${t("filters.cancelledInvoices")} ${I.status===h.Cancelled?`(${d})`:""}`,active:I.status===h.Cancelled,onClick:()=>A(h.Cancelled)}),e.jsxs("div",{className:"tgg-separator",children:[e.jsx("div",{className:"tgg-separator-line-1"}),e.jsx("div",{className:"tgg-label",children:t("filters.filterRange")}),e.jsx("div",{className:"tgg-separator-line-2"})]}),e.jsx(ya,{})]})}),e.jsxs("div",{className:"tgg-player-info-container",ref:i,children:[e.jsx("div",{className:"tgg-border-top"}),e.jsx("div",{className:"tgg-border-bottom"}),e.jsx("div",{className:"tgg-btn-addon-left"}),e.jsx("div",{className:"tgg-btn-addon-right"}),e.jsxs(je,{wrap:!1,className:"tgg-info-row",children:[e.jsx(K,{span:7,children:e.jsx("div",{className:"tgg-avatar",children:u?e.jsx("img",{src:u,alt:"avatar"}):e.jsx(Wt,{})})}),e.jsx(K,{span:17,children:e.jsxs("div",{className:"tgg-info",children:[e.jsx("div",{className:"tgg-name",children:x==null?void 0:x.fullName}),e.jsx("div",{className:"tgg-money",children:ee(ne(((S=x==null?void 0:x.money)==null?void 0:S.bank)??0),l)})]})})]})]})]})},Na=V.div.attrs({className:"tgg-loading"})`
	opacity: 0.25;

    .loading .dot {
        background: ${a.main.primaryColor};
    }

	@keyframes spin {
		from {
			transform: translateY(0);
			box-shadow: 0 0 0 ${a.main.primaryColor};
		}

		to {
			transform: translateY(-20px);
			box-shadow: 0 40px 0px ${a.main.secondaryColor};
		}
	}
`,wa=()=>e.jsx(Na,{children:e.jsxs("div",{className:"loading",children:[e.jsx("div",{className:"dot"}),e.jsx("div",{className:"dot"}),e.jsx("div",{className:"dot"}),e.jsx("div",{className:"dot"}),e.jsx("div",{className:"dot"}),e.jsx("div",{className:"dot"})]})}),ja=V.div.attrs({className:"tgg-invoices-dashboard",id:"tgg-invoices-dashboard"})`
	position: relative;
	height: 100%;
	width: 100%;

	overflow-y: auto;
	overflow-x: hidden;

	.tgg-invoices-wrapper {
		display: flex;
		flex-wrap: wrap;

		justify-content: space-evenly;

		padding: 0 1em;

		height: 100%;

		margin: 10px;
		margin-right: 0;
		margin-left: 0;

		gap: 2.5em;
		row-gap: 2.75em;
	}

	.tgg-empty-result {
		position: absolute;

		top: 20%;

		display: flex;
		flex-direction: column;
		align-items: center;

		width: 100%;

		svg {
			height: 250px;
			width: 250px;
			opacity: 0.2;
			color: ${a.main.primaryColor};
		}

		.tgg-empty-result-text {
			font-size: 1.25em;
			color: ${a.main.primaryTextColor};
		}
	}
`,_e=16,Ia=()=>{const[t,i]=f.useState(!0),[r,c]=f.useState(0),[s,g]=f.useState(!0),j=v(w=>w.totalInvoices),y=v(w=>w.UIVisible),d=v(w=>w.invoices),N=v(w=>w.filters),x=q(w=>w.setInvoices),_=q(w=>w.setHasNewInvoice),I=q(w=>w.setFlexOasisData),u=q(w=>w.setTotalInvoices),l=w=>Me.slice(_e*w,_e*w+_e);f.useEffect(()=>{y?($(!0),i(!1)):(x([]),c(0),u(0))},[y]),f.useEffect(()=>{t||$(!0)},[N]);const $=w=>{g(!0);let k=r;w&&(c(0),k=0,x([])),G("billing:invoice:all",{page:k,filters:N},void 0,{invoices:l(k??r),totalInvoices:100}).then(A=>{u(A==null?void 0:A.totalInvoices),(A==null?void 0:A.totalInvoices)>0&&(A!=null&&A.invoices)?k===0?setTimeout(()=>{x([...A.invoices])},250):x([...d.concat(A.invoices)]):x([]),c((k??r)+1),setTimeout(()=>{g(!1)},250)})};return xe("billing:update-invoices",w=>{if(N.type===Y.Personal&&(N.status===h.All||N.status===h.Unpaid)&&(N.society==="all"||N.society==="received")){const k=[...d];k.unshift(w),x([...k])}else _(!0);I({status:!0,message:"newInvoiceReceived"})}),xe("billing:on-invoice-paid",w=>{const k=[...d],A=k.find(n=>n.id===w.id);A&&(A.status=h.Paid,x([...k])),I({status:!0,message:"onInvoicePaid"})}),xe("billing:on-invoice-cancelled",w=>{const k=[...d],A=k.find(n=>n.id===w);A&&(A.status=h.Cancelled,x([...k])),I({status:!0,message:"onInvoiceCancelled"})}),xe("billing:on-invoice-accepted",w=>{const k=[...d],A=k.find(n=>n.id===w);A&&(A.status=h.Unpaid,x([...k])),I({status:!0,message:"onInvoiceAccepted"})}),xe("billing:on-invoice-rejected",w=>{const k=[...d],A=k.find(n=>n.id===w);A&&(A.status=h.Rejected,x([...k])),I({status:!0,message:"onInvoiceRejected"})}),xe("billing:notify-invoice-acceptance",()=>{I({status:!0,message:"onNotifyAcceptInvoice"})}),e.jsxs(ja,{children:[e.jsx(Ct,{dataLength:d.length,next:$,hasMore:d.length<j,loader:e.jsx(e.Fragment,{}),scrollableTarget:"tgg-invoices-dashboard",children:e.jsx("div",{className:"tgg-invoices-wrapper",children:f.useMemo(()=>d&&(d==null?void 0:d.map((w,k)=>e.jsx(Se,{type:O.Dashboard,invoice:w,body:e.jsx(Qe,{invoice:w,invoiceLocation:O.Dashboard}),footer:e.jsx(ze,{invoice:w,invoiceLocation:O.Dashboard})},k))),[d])})}),s&&d.length===0&&e.jsx(wa,{}),!s&&d.length===0&&e.jsx("div",{className:"tgg-empty-result",children:e.jsx(Yt,{})})]})},Pa=V.div.attrs({className:"tgg-create-invoice-btn"})`
	position: relative;

	display: flex;
	justify-content: start;
	align-items: center;

	height: 47.5px;
	min-width: 100px;
	width: auto;

	padding: 0 1em;

	${({$withIcon:t})=>t?"padding-right: 5em;":"justify-content: center;"}

	border: 1px solid ${a.button.buttonBorderColor};
	border-radius: 15px;

	border-right: none;

	background-color: #061726;

	overflow: hidden;

	box-shadow: 0px 0px 2.5px 0px ${a.button.buttonBorderColor};

	transition: all 0.25s ease-in-out;
	&:hover {
		cursor: pointer;
		box-shadow: 0px 0px 7.5px 0px ${a.button.buttonBorderColor};
	}

	.tgg-text {
		color: ${a.main.secondaryTextColor};
		font-weight: 600;
		font-size: 1.1em;
		line-height: 1em;
	}

	.tgg-icon-wrapper {
		svg {
			color: ${a.main.primaryColor};
			filter: opacity(0.9);
		}

		svg:first-child {
			position: absolute;

			right: 10px;
			bottom: -5px;
		}

		svg:last-child {
			position: absolute;

			right: 18.5px;
			bottom: -8.5px;
			filter: opacity(0.2);
		}
	}

	.tgg-right-attachment {
		position: absolute;
		right: 0;

		background: linear-gradient(
			0deg,
			rgba(30, 136, 229, 0.15) 0%,
			rgba(6, 23, 38, 0.5) 50%,
			rgba(30, 136, 229, 0.15) 100%
		);

		height: 100%;
		width: 2px;
	}

	.tgg-left-attachment {
		position: absolute;
		left: -3px;
		top: 50%;
		bottom: 50%;
		transform: translateY(-50%);

		height: 50%;
		width: 5px;

		background-color: ${a.button.buttonBorderColor};
		filter: drop-shadow(-1px 0px 5px ${a.button.buttonBorderColor});
	}
`,Re=({onClick:t,text:i,withIcon:r})=>{const{t:c}=te();return e.jsxs(Pa,{onClick:t,$withIcon:r,children:[e.jsx("div",{className:"tgg-left-attachment"}),e.jsx("div",{className:"tgg-right-attachment"}),e.jsx("div",{className:"tgg-text",children:c(i)}),r&&e.jsxs("div",{className:"tgg-icon-wrapper",children:[e.jsx(Ve,{}),e.jsx(Ve,{})]})]})},Sa=V.div.attrs({className:"tgg-content"})`
	display: flex;

	flex-direction: column;

	width: 100%;
	height: 100%;

	overflow: hidden;

	height: 100%;
	width: 85%;

	background-color: ${a.main.secondaryBackground};

	border-top-left-radius: 25px;

	.tgg-content-wrapper {
		display: flex;
		flex-direction: column;

		height: inherit;

		padding: 1em 0.75em 0 0;

		.tgg-header-section {
			.tgg-create-invoice-col {
				display: flex;

				gap: 1em;

				justify-content: end;
			}

			.tgg-searchbar {
				position: relative;

				display: flex;

				justify-content: center;
				align-items: center;

				width: 100%;
				height: 100%;

				input {
					height: 37.5px;
					width: 100%;

					padding: 0 1em;

					outline: none;
					border: none;
					border-radius: 15px;

					background-color: ${a.main.background};

					&::placeholder {
						color: #969696;
						font-family: 'Poppins', sans-serif;
						font-weight: 500;
					}

					color: ${a.main.secondaryTextColor};

					font-size: 1.1em;
					line-height: 1em;

					&:focus {
						box-shadow: 0 0 2.5px 0.5px ${a.main.primaryColor};
					}
				}

				.tgg-input-addon-icon-btn {
					position: absolute;

					display: flex;
					align-items: center;

					height: 100%;

					right: 10px;

					background: transparent;
					border: none;
					outline: none;

					svg path {
						color: ${a.main.primaryColor};
					}

					svg {
						transition: transform 0.15s ease-in-out;
					}

					&:disabled {
						cursor: not-allowed;
					}

					&:hover:not(:disabled) {
						cursor: pointer;

						svg {
							transform: scale(1.175);
							filter: opacity(0.75);
						}
					}
				}
			}
		}

		.tgg-body-section {
			position: relative;

			height: calc(
				100% - ${({$headerHeight:t})=>t}px
			);
			overflow: hidden;

			padding: 1em 0 0 0.75em;

			margin-bottom: 2em;

			.tgg-box-shadow {
				position: absolute;
				bottom: 0;
				height: 70px;
				width: 100%;

				z-index: 2;

				-webkit-box-shadow: inset 0px -35px 25px -30px rgba(0, 0, 0, 0.75);
				-moz-box-shadow: inset 0px -35px 25px -30px rgba(0, 0, 0, 0.75);
				box-shadow: inset 0px -35px 25px -30px rgba(0, 0, 0, 0.75);
			}
		}
	}

	.tgg-filters-left {
		display: flex;

		gap: 1em;

		.tgg-select {
			height: 100%;

			.ant-select-selector {
				display: flex;
				align-items: center;

				border: 1px solid ${a.main.secondaryTextColor};
				border-left: none;

				border-top-left-radius: 0;
				border-bottom-left-radius: 0;

				border-top-right-radius: 15px;
				border-bottom-right-radius: 15px;

				${({$dropdownOpen:t})=>t&&`
				border-bottom-right-radius: 0;
			`}

				outline: none;

				box-shadow: 0 0 2.5px 0.5px ${a.main.primaryColor};

				height: 100%;

				background-color: ${a.main.secondaryBackground};

				.ant-select-selection-search-input {
					::placeholder {
						color: ${a.main.secondaryTextColor};
					}

					font-size: 1em;
					color: ${a.main.secondaryTextColor} !important;
				}

				.ant-select-selection-item {
					color: ${a.main.secondaryTextColor};
				}

				.ant-select-item-empty {
					.ant-empty-image {
						svg {
							ellipse {
								display: none;
							}

							g {
								stroke: rgba(255, 255, 255, 0.1);

								fill: ${a.main.primaryColor};

								path:first-child {
									fill: #161a2f;
								}

								path:last-child {
									fill: #242a4a;
								}
							}
						}
					}

					.ant-empty-description {
						color: ${a.main.primaryTextColor};
						font-size: 1.1em;
						font-weight: 600;
					}
				}

				.ant-select-dropdown {
					will-change: transform;

					top: 46px !important;
					border-bottom-right-radius: 15px;
					border-bottom-left-radius: 0;

					border-top-left-radius: 0;
					border-top-right-radius: 0;

					background-color: ${a.main.secondaryBackground};

					border-top: 1px solid ${a.main.secondaryTextColor};
					border-right: 1px solid ${a.main.secondaryTextColor};
					border-bottom: 1px solid ${a.main.secondaryTextColor};

					box-shadow: 0px 0px 2.5px 0.5px ${a.main.primaryColor};

					.ant-select-item {
						background-color: ${a.main.secondaryBackground};
						padding: 0;

						&:last-child {
							.tgg-separator {
								display: none;
							}
						}
					}

					.ant-select-item-option-content {
						color: ${a.main.primaryTextColor};
					}

					.ant-select-item-option-selected {
						.tgg-option {
							color: ${a.main.primaryColor};
						}
					}

					.tgg-dropdown-option {
						position: relative;

						.tgg-separator {
							width: 90%;
							height: 2px;

							margin-left: 0.5em;

							box-shadow: 0px 0px 2.5px 0.5px ${a.main.primaryColor};

							background-color: ${a.main.primaryColor};

							filter: opacity(0.45);
						}

						.tgg-option {
							padding: 0.65em 2.5em 0.65em 0.5em;

							overflow: hidden;
							text-overflow: ellipsis;
							white-space: nowrap;

							transition:
								opacity,
								color 0.3s ease-in-out;
							&:hover {
								color: ${a.main.primaryColor};
								opacity: 0.85;
							}
						}

						.tgg-selected-icon {
							position: absolute;

							right: 10px;
							top: 50%;

							transform: translateY(-50%);

							display: flex;
							align-items: center;

							height: 100%;

							svg {
								line-height: 1em;
								font-size: 1.75em;
								color: ${a.main.primaryColor};
								opacity: 0.85;
							}
						}
					}

					.rc-virtual-list-scrollbar {
						width: 4px !important;

						.rc-virtual-list-scrollbar-thumb {
							background-color: ${a.main.primaryColor} !important;
						}
					}
				}

				&:before {
					content: '';
					position: absolute;

					top: 50%;
					bottom: 50px;
					transform: translateY(-50%);

					left: 0;

					height: 20px;
					width: 2.5px;

					background-color: ${a.main.primaryColor};
				}
			}

			.ant-select-arrow {
				font-size: 1em;
				font-weight: 600;

				display: flex;
				align-items: center;

				color: ${a.main.primaryColor};

				transition: transform 0.5s ease-in-out;

				${({$dropdownOpen:t})=>t&&`
				transform: rotate(360deg);
			`}
			}
		}

		.tgg-filter-btn {
			position: relative;

			display: flex;
			align-items: center;
			justify-content: center;

			svg {
				width: 27.5px;
				height: 25.5px;

				path {
					stroke: ${a.main.primaryColor};
				}
			}

			height: 47.5px;
			width: 47.5px;

			background-color: ${a.main.background};

			border-radius: 15px;
			border: 1px solid ${a.main.primaryColor};

			box-shadow: 0 0 1.5px 0.5px ${a.main.primaryColor};

			transition: border-radius 0.25s ease-in-out;
			&:hover {
				cursor: pointer;

				background-color: ${a.main.background};

				box-shadow: 0 0 1.5px 1px ${a.main.primaryColor};
			}

			${({$orderByDropdownOpen:t})=>t&&"border-radius: 15px 15px 0 0;"}

			.ant-dropdown {
				.ant-dropdown-menu {
					position: absolute;
					top: -5px;
					background-color: ${a.main.background} !important;
					box-shadow: 0 0 1.5px 0.5px ${a.main.primaryColor};

					border-top-left-radius: 0;
					border: 1px solid ${a.main.primaryColor};

					.ant-dropdown-menu-item {
						color: #fff;
						font-size: 1em;

						text-align: start;

						&:hover {
							color: ${p.p300};
						}

						&.ant-dropdown-menu-item-selected {
							background-color: transparent;
							color: ${a.main.primaryColor};
							font-weight: 600;
						}
					}
				}
			}
		}
	}

	::-webkit-scrollbar {
		width: 3px;
		height: 3px;

		background-clip: padding-box;
		padding: 1em 0;
	}

	::-webkit-scrollbar-button {
		width: 0px;
		height: 0px;
	}

	::-webkit-scrollbar-thumb {
		background: ${p.p700};
		border: 0px none ${p.p700};
		border-radius: 50px;
	}

	::-webkit-scrollbar-thumb:hover {
		background: ${p.p800};
	}

	::-webkit-scrollbar-thumb:active {
		background: ${p.p700};
	}

	::-webkit-scrollbar-track {
		background: ${a.main.primaryColor};
		border: 0px none ${a.main.primaryColor};

		border-radius: 50px;
	}

	::-webkit-scrollbar-track:hover {
		background: ${a.main.primaryColor};
	}

	::-webkit-scrollbar-track:active {
		background: ${a.main.primaryColor};
	}

	::-webkit-scrollbar-corner {
		background: transparent;
	}
`,La=()=>{const{t}=te(),i=f.useRef(null),[r,c]=f.useState(0),[s,g]=f.useState(!1),[j,y]=f.useState(!1),[d,N]=f.useState(!1),[x,_]=f.useState(""),[I,u]=f.useState([]),l=v(m=>m.settingsConfig),$=v(m=>m.playerData),w=v(m=>m.invoices),k=v(m=>m.filters),A=l.currencyFormat,n=q(m=>m.setViewInvoice),S=q(m=>m.setCustomModal),b=q(m=>m.setPlayerData),Z=q(m=>m.setInvoices),U=q(m=>m.setFilters),T=q(m=>m.setViewInvoiceModalOpen),X=q(m=>m.setFlexOasisData),pe=q(m=>m.setCreateInvoiceModalOpen),oe=[{value:"all",label:t("filters.all")},{value:"byMe",label:t("filters.byMe")}];f.useEffect(()=>{k.type===Y.Personal?(U({...k,society:"all"}),u(l==null?void 0:l.societyFilters)):k.type===Y.Society&&(u(oe),U({...k,society:"all"}))},[k.type]),f.useLayoutEffect(()=>{i.current&&c(i.current.clientHeight)},[i.current]);const he=m=>{U({...k,society:m})},ge=[{key:"newest",label:t("filters.newest"),onClick:()=>ae(ye.Newest)},{key:"oldest",label:t("filters.oldest"),onClick:()=>ae(ye.Oldest)},{key:"amountDesc",label:t("filters.amountDesc"),onClick:()=>ae(ye.AmountDesc)},{key:"amountAsc",label:t("filters.amountAsc"),onClick:()=>ae(ye.AmountAsc)}],ae=m=>{U({...k,orderBy:m})},ie=v(m=>m.companyConfig),me=v(m=>m.jobInfo),fe=()=>{var le;const m=ie==null?void 0:ie.create,F=(le=me==null?void 0:me.grade)==null?void 0:le.level;if(!m||m.length===0)return!1;if(k.type==Y.Society){if(m.includes("-1")||F&&m.includes(F))return!0}else if(k.type==Y.Personal&&m.includes(Y.Personal))return!0;return!1},L=m=>{var F;return(F=m==null?void 0:m.replace(/\s+/g,""))==null?void 0:F.trim()},H=()=>{if(!(x!=null&&x.trim())||s)return;const m=L(x);g(!0),G("billing:invoice:search-by-uuid",m,void 0,Me[0]).then(F=>{F?(n(F),T(J.Open),_("")):(X({status:!0,message:"invoiceNotFound"}),_("")),setTimeout(()=>{g(!1)},1e3)})},W=m=>{var F,le;if(l.allowOverdraft&&((F=$==null?void 0:$.money)!=null&&F.bank)){const C=$.money.bank,M=m,ke=l.overdraftLimit;if(C-M<-ke){X({status:!0,message:"exceedingOverdraftLimit"}),S(null);return}}else if((le=$==null?void 0:$.money)!=null&&le.bank&&$.money.bank<m){X({status:!0,message:"insufficientFunds"}),S(null);return}G("billing:invoice:pay-all",m,void 0,!0).then(C=>{var M;if(C){if($&&b({...$,money:{...$.money,bank:((M=$.money)==null?void 0:M.bank)-m}}),k.status===h.Unpaid||k.status===h.All){const ke=[...w];ke.forEach(Ne=>{Ne.status===h.Unpaid&&(Ne.status=h.Paid)}),Z(ke)}X({status:!0,message:"payAllSuccess"})}else X({status:!0,message:"payAllFailed"});S(null)})},ue=()=>{G("billing:invoice:get-total-payment-amount",null,void 0,1e3).then(m=>{if(m===0)X({status:!0,message:"noInvoicesToPay"});else{const F=ee(ne(m),A);S({visible:!0,bodyText:t("invoice.payAllConfirm",{totalAmount:F}),onOk:()=>W(m),onCancel:()=>S(null)})}})};return e.jsx(Sa,{$headerHeight:r,$dropdownOpen:d,$orderByDropdownOpen:j,children:e.jsxs("div",{className:"tgg-content-wrapper",children:[e.jsx("div",{className:"tgg-header-section",ref:i,children:e.jsxs(je,{children:[e.jsxs(K,{span:6,className:"tgg-filters-left",children:[e.jsx(Pe,{showSearch:!0,className:"tgg-select",style:{width:190},value:k==null?void 0:k.society,onSelect:he,open:d,filterOption:(m,F)=>{var le;return(((le=F==null?void 0:F.label)==null?void 0:le.toLowerCase())??"").includes(m.toLowerCase())},onDropdownVisibleChange:m=>N(m),options:I,getPopupContainer:m=>m,optionRender:m=>e.jsxs("div",{className:"tgg-dropdown-option",children:[m.key===(k==null?void 0:k.society)&&e.jsx("div",{className:"tgg-selected-icon",children:e.jsx(vt,{})}),e.jsx("div",{className:"tgg-option",children:m.label}),e.jsx("div",{className:"tgg-separator"})]})}),e.jsx(kt,{trigger:["click"],mouseEnterDelay:0,mouseLeaveDelay:0,open:j,getPopupContainer:m=>m,className:"tgg-filter-btn",menu:{items:ge,selectable:!0,defaultSelectedKeys:[ye.Newest],selectedKeys:[k==null?void 0:k.orderBy]},onOpenChange:m=>y(m),placement:"bottomLeft",children:e.jsx(Ye,{icon:e.jsx(Ht,{})})})]}),e.jsx(K,{span:10,children:e.jsxs("div",{className:"tgg-searchbar",children:[e.jsx("input",{type:"text",onKeyDown:m=>{m.key==="Enter"&&!s&&H()},value:x,onChange:m=>_(m.target.value),placeholder:t("filters.searchPlaceholder")}),e.jsx("button",{onClick:H,className:"tgg-input-addon-icon-btn",disabled:!x.trim().length||s,children:e.jsx(Vt,{})})]})}),e.jsxs(K,{span:8,className:"tgg-create-invoice-col",children:[k.type===Y.Personal&&e.jsx(Re,{text:"general.payAll",onClick:ue}),fe()&&e.jsx(Re,{text:"invoice.create",withIcon:!0,onClick:()=>pe(re.Open)})]})]})}),e.jsxs("div",{className:"tgg-body-section",children:[e.jsx(Ia,{}),w.length>4&&e.jsx("div",{className:"tgg-box-shadow"})]})]})})},$a=V.div.attrs({className:"tgg-dynamic-island"})`
	position: absolute;

	left: 50%;
	top: 12.5px;
	transform: translateX(-50%);

	width: calc(100% / 3);
	height: 30px;

	z-index: 999;

	img {
		position: relative;
		object-fit: contain;
		width: 100%;
		height: 100%;
		z-index: 3;

		left: 0;

		user-select: none;
		pointer-events: none;
	}

	.tgg-dynamic-expand {
		position: absolute;

		top: 0;

		left: 50%;
		transform: translateX(-50%);

		transition-property: width, height;
		transition-duration: 0.7s;
		transition-timing-function: ease-in-out;

		width: 130px;
		height: 30px;

		background-color: #000;

		border-radius: 50px;
		border: 1px solid #ffffff1a;

		overflow: hidden;

		z-index: 2;

		display: flex;

		padding: 10px 15px;

		.tgg-oasis-row {
			width: 100%;

			.tgg-oasis-col {
				display: flex;
				align-items: center;
			}
		}

		.tgg-dynamic-island-content {
			display: flex;
			align-items: center;
			gap: 12.5px;

			height: 100%;
			width: 100%;

			.tgg-icon {
				position: relative;

				display: flex;
				justify-content: center;
				align-items: center;

				width: 50px;
				height: 50px;

				border-radius: 50%;

				pointer-events: none;
				opacity: 0;

				will-change: transform;

				svg {
					width: 100%;
					height: 100%;
				}
			}

			.tgg-message {
				font-size: 1em;
				font-weight: 600;
				color: #fff;

				user-select: none;
				pointer-events: none;
				opacity: 0;

				will-change: transform;
			}
		}

		${({$expanded:t})=>t?`
            width: 325px;

            .tgg-dynamic-island-content {
                transition: opacity 0.5s ease-in-out;

                .tgg-icon, 
                .tgg-message {
                    transition: 0.5s ease-in-out;
				    transition-delay: 0.4s;
                    opacity: 1;
                }
            }
        `:`
                .tgg-icon, 
                .tgg-message {
                    transition-delay: 0.5s;
				    transition: 0.25s ease-in-out;
                }
        `}
	}
`,Ba=()=>{const{t}=te(),[i,r]=f.useState(30),[c,s]=f.useState(null),g=v(d=>d.flexOasisData),j=q(d=>d.setFlexOasisData);f.useEffect(()=>{if(g.status){let d=setTimeout(()=>{j({status:!1})},g.timeout??3e3);s(d)}else j({status:!1,message:void 0,timeout:-1}),clearTimeout(c);return()=>{clearTimeout(c)}},[g.status]),f.useEffect(()=>{y()},[g.status]);const y=()=>{let d=0;!g.message||!g.status?d=30:g.message.length<=30?d=75:g.message.length<=50?d=85:g.message.length<=70?d=97.5:g.message.length<=85?d=105:g.message.length<=200&&(d=135),r(d)};return e.jsxs($a,{$expanded:g.status,children:[e.jsx("img",{src:"utils/camera.png",alt:""}),e.jsx("div",{className:"tgg-dynamic-expand",style:{height:`${i}px`},children:e.jsx("div",{className:"tgg-dynamic-island-content",children:e.jsxs(je,{className:"tgg-oasis-row",children:[e.jsx(K,{span:5,className:"tgg-oasis-col",children:e.jsx("div",{className:"tgg-icon",children:e.jsx(Rt,{})})}),e.jsx(K,{span:19,className:"tgg-oasis-col",children:e.jsx("div",{className:"tgg-message",children:g.message&&t(`notifications.${g.message}`)})})]})})})]})},qa=V.header`
	position: relative;

	display: flex;

	justify-content: space-between;
	align-items: center;

	padding: 0 1em;

	width: 100%;
	min-height: 6.5%;

	border-bottom: 1px solid ${a.main.border};

	.tgg-menu-type {
		font-size: 1em;
		font-weight: 600;

		color: ${a.main.primaryTextColor};
	}

	.tgg-buttons-wrapper {
		position: relative;

		display: flex;
		gap: 0.5em;

		.tgg-header-btn {
			display: flex;
			justify-content: center;
			align-items: center;

			height: 1.75em;
			width: 1.75em;

			background-color: ${a.button.headerBg};

			border-radius: 10px;

			transition: all 0.3s;

			aspect-ratio: 1/1;

			border: 1px solid transparent;

			&:hover {
				cursor: pointer;

				border: 1px solid ${a.button.headerBorderHover};
			}

			svg {
				color: ${a.button.headerIconColor};
			}

			&.tgg-close svg {
				font-size: 1.75em;
				color: ${a.button.headerIconColor};
			}

			&.tgg-settings svg {
				font-size: 1em;
				color: ${a.button.headerIconLightColor};
			}

			&.tgg-more {
				&.tgg-expanded {
					border: 1px solid ${a.button.headerBorderHover};
					box-shadow: 0 0 5px 0 ${a.button.headerBorderHover};

					svg {
						transform: rotate(90deg);
					}
				}

				svg {
					transition: transform 0.3s ease-in-out;
					font-size: 1.2em;
					color: ${a.button.headerIconLightColor};
				}
			}

			&.tgg-statistics svg {
				font-size: 0.9em;
				color: ${a.button.headerIconLightColor};
			}

			&.tgg-admin svg {
				font-size: 1.15em;
				color: ${a.button.headerIconLightColor};
			}
		}
	}

	.tgg-more-actions {
		gap: 0.25em;

		width: 0;
		display: none;

		&.tgg-expanded {
			display: flex;

			width: auto;
		}
	}
`,Aa=()=>{var N;const[t,i]=f.useState(!1),r=v(x=>x.jobInfo),c=r==null?void 0:r.label,s=(N=r==null?void 0:r.grade)==null?void 0:N.name,g=q(x=>x.setSettingsDrawerOpen),j=q(x=>x.setStatisticsOpen),y=()=>{G("billing:close")},d=()=>{i(!t)};return e.jsxs(qa,{children:[e.jsx("div",{className:"tgg-menu-type",children:c+": "+s}),e.jsx(Ba,{}),e.jsxs("div",{className:"tgg-buttons-wrapper",children:[e.jsxs("div",{className:`tgg-more-actions ${t?"tgg-expanded":"tgg-collapsed"}`,children:[e.jsx("div",{className:"tgg-header-btn tgg-statistics",onClick:()=>{i(!1),j(de.Open)},children:e.jsx(Nt,{})}),e.jsx("div",{className:"tgg-header-btn tgg-settings",onClick:()=>g(!0),children:e.jsx(wt,{})})]}),e.jsx("div",{className:`tgg-header-btn tgg-more${t?" tgg-expanded":""}`,onClick:d,children:e.jsx(De,{})}),e.jsx("div",{className:"tgg-header-btn tgg-close",onClick:y,children:e.jsx(jt,{})})]})]})},_a=V.div.attrs({className:"tgg-app-grid"})`
	position: relative;

	display: flex;

	flex-direction: column;

	height: 100%;
	width: 100%;

	background-color: ${a.main.background};

	border-radius: 27.5px;

	overflow: hidden;

	.tgg-section-wrapper {
		display: flex;

		height: 93.5%;
		width: 100%;

		padding-top: 1.25em;
	}

	.tgg-payment-confirm-modal-root {
		.ant-modal-mask {
			z-index: 500;
			position: absolute;
			height: 100%;
			width: 100%;

			backdrop-filter: blur(6px);
			background-color: rgba(0, 0, 0, 0.2);
			box-shadow: inset 0 0 200px 1px ${Ce.insetShadow};
		}

		.tgg-payment-confirm-modal {
			.ant-modal-content,
			.ant-modal-title {
				background-color: ${a.main.background};
			}

			.ant-modal-content {
				padding: 0;
				box-shadow: 0 0 20.5px 0.5px rgba(0, 0, 0, 0.35);

				height: 200px;

				.ant-modal-body {
					height: 100%;

					.tgg-modal-content {
						position: relative;

						height: 100%;
						width: 100%;

						display: flex;
						flex-direction: column;

						justify-content: center;
						align-items: center;

						will-change: transform;

						.tgg-modal-info-icon {
							position: absolute;

							right: 50%;
							left: 50%;
							transform: translateX(-50%);

							top: -35px;

							display: flex;
							justify-content: center;
							align-items: center;

							width: 100px;
							height: 100px;

							padding: 22.5px;

							border-radius: 50%;

							background-color: ${a.main.secondaryBackground};

							box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.35);

							svg {
								color: #fff;
							}
						}

						.tgg-modal-body {
							display: flex;

							flex-direction: column;

							justify-content: space-evenly;
							align-items: center;

							width: 100%;

							height: 100%;

							margin-top: 55px;

							will-change: transform;
							.tgg-modal-info-text {
								color: ${p.p300};

								font-size: 1.15em;
								font-weight: 600;

								text-align: center;

								padding: 0 2em;
							}

							.tgg-modal-buttons {
								display: flex;

								gap: 1em;

								margin-top: 1em;

								.tgg-modal-cancel-btn {
									background-color: transparent;

									color: ${a.main.primaryColor};

									font-size: 1em;
									font-weight: 600;

									padding: 0.5em 1em;

									border-radius: 5px;

									outline: none;
									border: none;

									transition: color 0.25s ease-in-out;
									&:hover {
										cursor: pointer;
										color: #fff;
									}
								}

								.tgg-modal-confirm-btn {
									background-color: ${a.main.primaryColor};

									color: #fff;

									font-size: 1em;
									font-weight: 600;

									padding: 0.5em 1em;

									border-radius: 5px;

									outline: none;
									border: none;

									transition: box-shadow 0.25s ease-in-out;
									&:hover {
										cursor: pointer;

										box-shadow: 0 0 10px 0 ${a.main.primaryColor};
									}
								}
							}
						}
					}
				}
			}
		}
	}
`,Za=()=>e.jsxs(_a,{children:[e.jsx(Aa,{}),e.jsxs("div",{className:"tgg-section-wrapper",children:[e.jsx(ka,{}),e.jsx(La,{})]}),e.jsx(da,{}),e.jsx(ga,{}),e.jsx(ua,{}),e.jsx(fa,{})]}),Qa=V.div.attrs({className:"tgg-tablet-app"})`
	width: 1520px;
	height: 860px;

	transform: translate3d(0, 0, 0) scale(${t=>t.$resizeBy});

	overflow: hidden;

	border-radius: 30px;
	padding: 0.3em;
	background-color: #000;

	filter: drop-shadow(3px 3px 5px #0000001f);
`,za=()=>{const t=v(i=>i.resizeBy);return e.jsxs(Qa,{$resizeBy:t,children:[e.jsx(Za,{}),e.jsx(Gt,{})]})};Xe([{action:"billing:set-visible",data:{visible:ve(),jobInfo:aa,playerData:ia,companyConfig:na}}],1e3);const Ma=()=>{const{i18n:t}=te(),[i,r]=f.useState(null),c=v(n=>n.UIVisible),s=v(n=>n.acceptInvoiceVisible),g=q(n=>n.setPlayerData),j=q(n=>n.setUIVisible),y=q(n=>n.setInvoices),d=q(n=>n.setJobInfo),N=q(n=>n.setMugshot),x=q(n=>n.setAcceptInvoiceVisible),_=q(n=>n.setSettingsConfig),I=q(n=>n.setTotalInvoices),u=q(n=>n.setCompanyConfig);f.useEffect(()=>{if(!c)return;const n=S=>{["Escape"].includes(S.code)?ve()||(S.preventDefault(),G("billing:close").then(()=>{$()})):["Backquote"].includes(S.code)&&ve()&&Xe([{action:"toggle-dev-menu",data:!0}],0)};return window.addEventListener("keyup",n),()=>window.removeEventListener("keyup",n)},[c]),f.useEffect(()=>{var n;if(document.getElementsByTagName("html")[0].style.visibility="visible",document.getElementsByTagName("body")[0].style.visibility="visible",ve()&&window.location.hostname==="localhost"){const S=document.getElementById("app");S&&(S.style.backgroundColor="#313131");const b=(n=document.getElementById("app"))==null?void 0:n.style;b&&(b.background="url(utils/bgdummy.jpg) no-repeat")}G("billing:misc:get-config",null,void 0,ra).then(S=>{S&&(_(S),t.changeLanguage(S.language))})},[]);const l=n=>{n.visible&&(g(n.playerData),d(w(n.jobInfo)),u(k(n.companyConfig)),N(n==null?void 0:n.mugshot)),j(n.visible)},$=()=>{I(0),y([])},w=n=>{const S={...n};return S.grade.level=n.grade.level.toString(),S},k=n=>{var b;const S={...n};return S.create=n.create.map(Z=>Z=Z.toString()),S.cancel=n.cancel.map(Z=>Z=Z.toString()),S.comission=((b=n==null?void 0:n.comission)==null?void 0:b.map(Z=>({...Z,grade:Z.grade.toString()})))??[],S};xe("billing:set-visible",n=>l(n)),f.useEffect(()=>{s||setTimeout(()=>{r(null)},500)},[s]);const A=n=>{g(n.playerData),r(n.invoice),setTimeout(()=>{x(!0)},500)};return xe("billing:ask-invoice-acceptance",n=>A(n)),e.jsx(Oa,{children:e.jsxs("div",{id:"app",className:"app","data-theme":"dark",children:[c&&e.jsx(za,{}),e.jsx(Tt,{invoice:i})]})})},Oa=({children:t})=>e.jsx("div",{className:"browser-wrapper",children:t});Ae.use(It).init({debug:!1,fallbackLng:"en",defaultNS:"translation",interpolation:{escapeValue:!1},resources:{en:{translation:We("en").then(t=>{Ae.addResourceBundle("en","translation",t)}).catch(t=>{console.error("i18n:Failed to load translations:",t)})},de:{translation:We("de").then(t=>{Ae.addResourceBundle("de","translation",t)}).catch(t=>{console.error("i18n:Failed to load translations:",t)})}}});const Fa=Pt.createRoot(document.getElementById("root")),Ta=St;(window.name==="tgg-billing"||ve())&&Fa.render(e.jsx(Ta,{store:Bt,children:e.jsx(Ma,{})}));
