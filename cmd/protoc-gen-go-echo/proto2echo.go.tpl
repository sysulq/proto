type {{ $.InterfaceName }} interface {
{{range .MethodSet}}
	{{.Name}}(context.Context, *{{.Request}}) (*{{.Reply}}, error)
{{end}}
}
func Register{{ $.InterfaceName }}(r *v4.Echo, srv {{ $.InterfaceName }}) {
	s := {{.Name}}{
		server: srv,
		router:     r,
	}
	s.RegisterService()
}

type {{$.Name}} struct{
	server {{ $.InterfaceName }}
	router *v4.Echo
}

{{range .Methods}}
func (s *{{$.Name}}) {{ .HandlerName }} (ctx v4.Context) error {
	var in {{.Request}}
	if err := ctx.Bind(&in); err != nil {
		ctx.Error(v4.NewHTTPError(200, err))
		return nil
	}
	md := metadata.New(nil)
	for k, v := range ctx.Request().Header {
		md.Set(k, v...)
	}
	newCtx := metadata.NewIncomingContext(ctx.Request().Context(), md)
	out, err := s.server.({{ $.InterfaceName }}).{{.Name}}(newCtx, &in)
	if err != nil {
		ctx.Error(v4.NewHTTPError(200, err))
		return nil
	}

	return ctx.JSON(http.StatusOK, out)
}
{{end}}

func (s *{{$.Name}}) RegisterService() {
{{range .Methods}}	s.router.Add("{{.Method}}", "{{.Path}}", s.{{ .HandlerName }}){{end}}
}
